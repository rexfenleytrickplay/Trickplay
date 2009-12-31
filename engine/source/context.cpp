#include <cstdio>
#include <cstring>
#include <sstream>

#include "curl/curl.h"
#include "clutter/clutter.h"

#include "context.h"
#include "network.h"
#include "lb.h"
#include "util.h"
#include "console.h"

//-----------------------------------------------------------------------------
// Bindings
//-----------------------------------------------------------------------------

extern void luaopen_clutter(lua_State*L);
extern void luaopen_timer(lua_State*L);
extern void luaopen_url_request(lua_State*L);
extern void luaopen_storage(lua_State*L);
extern void luaopen_globals(lua_State*L);
extern void luaopen_app(lua_State*L);

//-----------------------------------------------------------------------------
// Internal context
//-----------------------------------------------------------------------------

TPContext::TPContext()
:
    L(NULL),
    external_console_handler(NULL),
    external_console_handler_data(NULL)
{
}
    
//-----------------------------------------------------------------------------

TPContext::~TPContext()
{
}

//-----------------------------------------------------------------------------

void TPContext::set(const char * key,const char * value)
{
    g_assert(!running());
    
    config.insert(std::make_pair(String(key),String(value)));
}

//-----------------------------------------------------------------------------

const char * TPContext::get(const char * key,const char * def)
{    
    StringMap::const_iterator it = config.find(String(key));
    
    if (it==config.end())
        return def;
    return it->second.c_str();
}

//-----------------------------------------------------------------------------

int TPContext::console_command_handler(const char * command,const char * parameters,void * self)
{
    TPContext * context = (TPContext*)self;
    
    if (!strcmp(command,"exit"))
    {
	context->quit();
	return TRUE;
    }
    
    return FALSE;
}

//-----------------------------------------------------------------------------

int TPContext::run()
{    
    // So that run cannot be called while we are running
    g_assert(!running());
    
    if (external_log_handler)
	g_log_set_default_handler(log_handler,this);        
	
    
    // Get the base path for the app
    const char * app_path = get( APP_PATH );
    
    if (!app_path)
    {
	gchar * c = g_get_current_dir();
	set( APP_PATH , c );
	g_free(c);
	
	app_path = get(APP_PATH);
    }
    
    if (!load_app_metadata(app_path))
	return 1;
    
    // Start up a lua state
    L = lua_open();
    
    // Put a pointer to us in Lua so bindings can get to it
    lua_pushstring(L,"tp_context");
    lua_pushlightuserdata(L,this);
    lua_rawset(L,LUA_REGISTRYINDEX);
    
    // Open standard libs
    luaL_openlibs(L);
    
    // Open our stuff
    luaopen_clutter(L);
    luaopen_timer(L);
    luaopen_url_request(L);
    luaopen_storage(L);
    luaopen_globals(L);
    luaopen_app(L);
    
    // Run the script
    gchar * main_path=g_build_filename(app_path,"main.lua",NULL);
    Util::GFreeLater free_main_path(main_path);
    
    int result = luaL_dofile(L,main_path);

    if (result)
    {
        g_error("%s",lua_tostring(L,-1));
    }
    else
    {
#ifndef TP_PRODUCTION	
	Console console(L);
	console.add_command_handler(console_command_handler,this);
	
	if (external_console_handler)
	    console.add_command_handler(external_console_handler,external_console_handler_data);
#endif	
        clutter_actor_show_all(clutter_stage_get_default());
        clutter_main();
    }
    
    clutter_group_remove_all(CLUTTER_GROUP(clutter_stage_get_default()));
    
    Network::shutdown();
    
    lua_close(L);
    
    L=NULL;
    
    return result;
}

//-----------------------------------------------------------------------------

void TPContext::quit()
{
    g_assert(running());
    
    clutter_main_quit();
}
   
//-----------------------------------------------------------------------------

TPContext * TPContext::get_from_lua(lua_State * L)
{
    g_assert(L);
    lua_pushstring(L,"tp_context");
    lua_rawget(L,LUA_REGISTRYINDEX);
    TPContext * result = (TPContext*)lua_touserdata(L,-1);
    lua_pop(L,1);
    g_assert(result);
    return result;
}

//-----------------------------------------------------------------------------

bool TPContext::load_app_metadata(const char * app_path)
{
    g_assert(app_path);
    
    // Open a state with no libraries - not even the base one
    
    lua_State * L=lua_open();
    
    g_assert(L);
    
    try
    {
	// Build the path to the metadata file and test that it exists
	
	gchar * path = g_build_filename(app_path,APP_METADATA_FILENAME,NULL);
	
	Util::GFreeLater free_path(path);
	
	if (!g_file_test(path,G_FILE_TEST_IS_REGULAR))
	    throw String("App metadata file does not exist");
	
	// Now, run it with Lua
	
	int result = luaL_dofile(L,path);
	
	// Check that it ran OK
	
	if(result)
	    throw String("Failed to parse app metadata : ") + lua_tostring(L,-1);
	    
	// Look for the 'app' global
	
	lua_getglobal(L,APP_TABLE_NAME);	
	if (!lua_istable(L,-1))
	    throw String("Missing or invalid app table");
	    
	// Look for the id
	lua_getfield(L,-1,APP_FIELD_ID);
	if (lua_type(L,-1)!=LUA_TSTRING)
	    throw String("Missing or invalid app id");
	    
	// Validate the id
	
	size_t len;
	const char * s=lua_tolstring(L,-1,&len);
	
	if (len>64)
	    throw String("App id is too long");
	
	static const char * valid_id_characters = "_-.";
	
	for(const char * c=s;*c;++c)
	{
	    if (!g_ascii_isalnum(*c))
	    {
		if(!strchr(valid_id_characters,*c))
		    throw String("App id contains invalid characters");
	    }
	}
	
	if (strstr(s,".."))
	    throw String("App id contains two dots");

	if (strstr(s,"--"))
	    throw String("App id contains two dashes");
	    
	if (strstr(s,"__"))
	    throw String("App id contains two underscores");
	    
	
	// Store it
	set(APP_ID,s);
	lua_pop(L,1);

	// Look for the other fields
	lua_getfield(L,-1,APP_FIELD_NAME);
	if (lua_type(L,-1)!=LUA_TSTRING)
	    throw String("Missing or invalid app name");
	set(APP_NAME,lua_tostring(L,-1));
	lua_pop(L,1);
	
	lua_getfield(L,-1,APP_FIELD_RELEASE);
	if (lua_tointeger(L,-1)<=0)
	    throw String("Missing or invalid app release, it must be a number greater than 0");
	std::stringstream str;
	str << lua_tointeger(L,-1);
	set(APP_RELEASE,str.str().c_str());
	lua_pop(L,1);
	
	lua_getfield(L,-1,APP_FIELD_VERSION);
	if (lua_type(L,-1)!=LUA_TSTRING)
	    throw String("Missing or invalid app version");
	set(APP_VERSION,lua_tostring(L,-1));
	lua_pop(L,1);
	
	lua_getfield(L,-1,APP_FIELD_DESCRIPTION);
	if(lua_isstring(L,-1))
	    set(APP_DESCRIPTION,lua_tostring(L,-1));
	lua_pop(L,1);
	
	lua_getfield(L,-1,APP_FIELD_AUTHOR);
	if(lua_isstring(L,-1))
	    set(APP_AUTHOR,lua_tostring(L,-1));
	lua_pop(L,1);
	
	lua_getfield(L,-1,APP_FIELD_COPYRIGHT);
	if(lua_isstring(L,-1))
	    set(APP_COPYRIGHT,lua_tostring(L,-1));
	lua_pop(L,1);
	
	lua_close(L);
	return true;	
    }
    catch( const String & e)
    {
	lua_close(L);
	g_warning("Failed to load app metadata from '%s' : %s" , app_path , e.c_str() );
	return false;	
    }
}

//-----------------------------------------------------------------------------

void TPContext::set_command_handler(TPConsoleCommandHandler handler,void * data)
{
    g_assert(!running());
    
    external_console_handler = handler;    
    external_console_handler_data = data;
}

//-----------------------------------------------------------------------------

void TPContext::log_handler(const gchar * log_domain,GLogLevelFlags log_level,const gchar * message,gpointer self)
{
    TPContext * context=(TPContext*)self;
    
    context->external_log_handler(log_level,log_domain,message,context->external_log_handler_data);
}

//-----------------------------------------------------------------------------

void TPContext::set_log_handler(TPLogHandler handler,void * data)
{
    g_assert(!running());
    
    external_log_handler = handler;
    external_log_handler_data = data;
}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

void log_handler(const gchar * log_domain,GLogLevelFlags log_level,const gchar *message,gpointer user_data)
{
    gulong ms = clutter_get_timestamp() / 1000;
    
    int sec = 0;
    int min = 0;
    int hour = 0;

    if (ms >= 1000)
    {
        sec = ms / 1000;
        ms %= 1000;

        if (sec >= 60)
        {
            min = sec / 60;
            sec %= 60;

            if (min >= 60)
            {
                hour = min / 60;
                min %= 60;
            }
        }
    }

    const char * level = "OTHER";
    
    if (log_level&G_LOG_LEVEL_ERROR)
        level = "ERROR";
    else if (log_level&G_LOG_LEVEL_CRITICAL)
        level = "CRITICAL";
    else if (log_level&G_LOG_LEVEL_WARNING)
        level = "WARNING";
    else if (log_level&G_LOG_LEVEL_MESSAGE)
        level = "MESSAGE";
    else if (log_level&G_LOG_LEVEL_INFO)
        level = "INFO";
    else if (log_level&G_LOG_LEVEL_DEBUG)
        level = "DEBUG";
    
    fprintf(stderr,"%p %2.2d:%2.2d:%2.2d:%3.3lu %s %s %s\n" ,
            g_thread_self() ,
            hour , min , sec , ms , level , log_domain , message );
}

//-----------------------------------------------------------------------------
// External-facing functions
//-----------------------------------------------------------------------------

void tp_init(int * argc,char *** argv)
{
    if(!g_thread_supported())
	g_thread_init(NULL);
        
    ClutterInitError ce = clutter_init(argc,argv);
    
    if (ce != CLUTTER_INIT_SUCCESS)
	g_error("Failed to initialize Clutter : %d",ce);
    
    CURLcode co = curl_global_init(CURL_GLOBAL_ALL);
    
    if (co != CURLE_OK)
	g_error("Failed to initialize cURL : %s" , curl_easy_strerror(co));
    
    g_log_set_default_handler(log_handler,NULL);        
}

//-----------------------------------------------------------------------------

TPContext * tp_context_new()
{
    return new TPContext;    
}

//-----------------------------------------------------------------------------

void tp_context_free(TPContext * context)
{
    g_assert(context);
    g_assert(!context->running());
    
    delete context;    
}

//-----------------------------------------------------------------------------

void tp_context_set(TPContext * context,const char * key,const char * value)
{
    context->set(key,value);    
}

//-----------------------------------------------------------------------------

const char * tp_context_get(TPContext * context,const char * key)
{
    return context->get(key);
}

//-----------------------------------------------------------------------------

void tp_context_set_console_command_handler(TPContext * context,TPConsoleCommandHandler handler,void * data)
{
    context->set_command_handler(handler,data);    
}

//-----------------------------------------------------------------------------

void tp_context_set_log_handler(TPContext * context,TPLogHandler handler,void * data)
{
    context->set_log_handler(handler,data);
}

//-----------------------------------------------------------------------------

int tp_context_run(TPContext * context)
{
    return context->run();
}

//-----------------------------------------------------------------------------

void tp_context_quit(TPContext * context)
{
    context->quit();    
}

//-----------------------------------------------------------------------------
