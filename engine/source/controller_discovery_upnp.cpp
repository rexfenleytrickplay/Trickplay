
#include <iostream>
#include <cstring>
#include <sstream>

#include <upnp/upnp.h>
#include <upnp/upnptools.h>

#if ! UPNP_HAVE_TOOLS
#error "UPnP LIBRARY NEEDS TO BE COMPILED WITH UPNP_HAVE_TOOLS"
#endif


#include "controller_discovery_upnp.h"
#include "common.h"
#include "context.h"
#include "sysdb.h"

//=============================================================================

static const char * device_xml_template =

    "<?xml version=\"1.0\"?>"
    "<root xmlns=\"urn:schemas-upnp-org:device-1-0\">"
    "    <specVersion>"
    "        <major>1</major>"
    "        <minor>0</minor>"
    "    </specVersion>"
    "    <device>"
    "        <deviceType>urn:schemas-trickplay-com:device:TrickPlay:1</deviceType>"
    "        <friendlyName>%s</friendlyName>"
    "        <manufacturer>TrickPlay</manufacturer>"
    "        <modelDescription>TrickPlay</modelDescription>"
    "        <modelName>TrickPlay</modelName>"
    "        <modelNumber>%d.%d.%d</modelNumber>"
    "        <serialNumber>%s</serialNumber>"
    "        <UDN>uuid:%s</UDN>"
    "        <serviceList>"
    "            <service>"
    "                <serviceType>urn:schemas-trickplay-com:service:Controller:1</serviceType>"
    "                <serviceId>urn:upnp-org:serviceId:1</serviceId>"
    "                <SCPDURL>/controller-scpd.xml</SCPDURL>"
    "                <controlURL>/controller/control</controlURL>"
    "                <eventSubURL>/controller/events</eventSubURL>"
    "            </service>"
    "        </serviceList>"
    "    </device>"
    "</root>";

static char * device_xml = 0;

static void prepare_device_xml( TPContext * context , const String & name )
{
    if ( device_xml )
    {
        g_free( device_xml );
        device_xml = 0;
    }

    String serial_number = context->get( TP_SYSTEM_SN , TP_SYSTEM_SN_DEFAULT );

    String uuid = context->get_db()->get_string( TP_DB_UUID );

    device_xml = g_strdup_printf(
            device_xml_template,
            name.c_str(),
            TP_MAJOR_VERSION,
            TP_MINOR_VERSION,
            TP_PATCH_VERSION,
            serial_number.c_str(),
            uuid.c_str() );
}

static const char * controller_scpd_xml =

    "<?xml version=\"1.0\"?>"
    "<scpd>"
    "    <specVersion>"
    "        <major>1</major>"
    "        <minor>0</minor>"
    "    </specVersion>"
    "    <actionList>"
    "        <action>"
    "            <name>getport</name>"
    "            <argumentList>"
    "                <argument>"
    "                    <name>port</name>"
    "                    <direction>out</direction>"
    "                    <retval/>"
    "                    <relatedStateVariable>port</relatedStateVariable>"
    "                </argument>"
    "            </argumentList>"
    "        </action>"
    "    </actionList>"
    "    <serviceStateTable>"
    "        <stateVariable sendEvents=\"no\">"
    "            <name>port</name>"
    "            <dataType>ui4</dataType>"
    "        </stateVariable>"
    "    </serviceStateTable>"
    "</scpd>";


//=============================================================================

static int upnp_virtual_get_info( const char *filename , File_Info * info )
{
    if ( ! strcmp( filename , "/device.xml" ) )
    {
        info->file_length = strlen( device_xml );
        info->content_type = ixmlCloneDOMString( "text/xml" );
        info->is_directory = 0;
        info->is_readable = 1;
        return 0;
    }
    else if ( ! strcmp( filename , "/controller-scpd.xml" ) )
    {
        info->file_length = strlen( controller_scpd_xml );
        info->content_type = ixmlCloneDOMString( "text/xml" );
        info->is_directory = 0;
        info->is_readable = 1;
        return 0;
    }

    return -1;
}

static UpnpWebFileHandle upnp_virtual_open( const char * filename, enum UpnpOpenFileMode Mode )
{
    UpnpWebFileHandle result = ( UpnpWebFileHandle ) 0;

    if ( Mode == UPNP_READ )
    {
        if ( ! strcmp( filename , "/device.xml" ) )
        {
            result = ( UpnpWebFileHandle ) new std::istringstream( device_xml );
        }
        else if ( ! strcmp( filename , "/controller-scpd.xml" ) )
        {
            result = ( UpnpWebFileHandle ) new std::istringstream( controller_scpd_xml );
        }
    }

    return result;
}


static int upnp_virtual_read( UpnpWebFileHandle fileHnd, char * buf, size_t buflen)
{
    std::istringstream * stream = ( std::istringstream * ) fileHnd;

    if ( stream->eof() )
    {
        return 0;
    }

    stream->read( buf , buflen );

    return stream->gcount();
}

static int upnp_virtual_write( UpnpWebFileHandle fileHnd, char * buf, size_t buflen )
{
    return 0;
}

static int upnp_virtual_seek( UpnpWebFileHandle fileHnd, off_t offset, int origin )
{
    std::istringstream * stream = ( std::istringstream * ) fileHnd;

    std::ios_base::seekdir dir = ( origin == SEEK_CUR ? std::ios_base::cur : origin == SEEK_END ? std::ios_base::end : std::ios_base::beg );

    stream->seekg( offset , dir );

    if ( stream->fail() )
    {
        return -1;
    }

    return 0;
}

static int upnp_virtual_close( UpnpWebFileHandle fileHnd )
{
    std::istringstream * stream = ( std::istringstream * ) fileHnd;

    delete stream;

    return 0;
}

//=============================================================================


ControllerDiscoveryUPnP::ControllerDiscoveryUPnP( TPContext * context, const String & name, int port )
:
    controller_name( name ),
    controller_port( port ),
    device_handle( 0 )
{
    prepare_device_xml( context , name );

    int result;

    static bool init = false;

    if ( ! init )
    {
        if ( UPNP_E_SUCCESS != UpnpInit( 0 , 0 ) )
        {
            g_warning( "FAILED TO INITIALIZE UPnP" );

            return;
        }
        else
        {
            init = true;
        }
    }

    UpnpVirtualDirCallbacks callbacks;


    callbacks.get_info = upnp_virtual_get_info;
    callbacks.open = upnp_virtual_open;
    callbacks.read = upnp_virtual_read;
    callbacks.write = upnp_virtual_write;
    callbacks.seek = upnp_virtual_seek;
    callbacks.close = upnp_virtual_close;

    UpnpSetVirtualDirCallbacks( & callbacks );

    if ( UPNP_E_SUCCESS != UpnpAddVirtualDir( "/" ) )
    {
        g_warning( "FAILED TO ADD UPnP VIRTUAL DIRECTORY" );

        return;
    }

    if ( UPNP_E_SUCCESS != UpnpEnableWebserver( 1 ) )
    {
        g_warning( "FAILED TO ENABLE UPnP WEB SERVER" );

        return;
    }

    std::stringstream url;

    url << "http://" << UpnpGetServerIpAddress() << ":" << UpnpGetServerPort() << "/device.xml";

    if ( UPNP_E_SUCCESS != UpnpRegisterRootDevice2(
            UPNPREG_URL_DESC,
            url.str().c_str(),
            0,
            1,
            upnp_device_callback,
            this,
            & device_handle ) )
    {
        g_warning( "FAILED TO REGISTER UPnP ROOT DEVICE" );

        return;
    }

    if ( UPNP_E_SUCCESS != UpnpSendAdvertisement( device_handle , 10 ) )
    {
        g_warning( "FAILED TO SEND UPnP ADVERTISEMENT" );
    }

    g_info( "UPnP CONTROLLER DISCOVERY READY AT %s:%u" , UpnpGetServerIpAddress() , UpnpGetServerPort() );

}

ControllerDiscoveryUPnP::~ControllerDiscoveryUPnP()
{
    if ( device_handle )
    {
        UpnpUnRegisterRootDevice( device_handle );

        UpnpEnableWebserver( 0 );
    }

    g_free( device_xml );
}

bool ControllerDiscoveryUPnP::is_ready() const
{
    return device_handle != 0;
}

int ControllerDiscoveryUPnP::upnp_device_callback( Upnp_EventType type , void * event , void * user )
{
    g_debug( "UPnP DEVICE EVENT TYPE %d" , type );

    ControllerDiscoveryUPnP * self = ( ControllerDiscoveryUPnP * ) user;

    switch( type )
    {
        case UPNP_CONTROL_ACTION_REQUEST:
            {
                Upnp_Action_Request * r = ( Upnp_Action_Request * ) event;

                if ( ! strcmp( "getport" , r->ActionName ) )
                {
                    std::stringstream port;

                    port << self->controller_port;

                    IXML_Document * response = UpnpMakeActionResponse(
                            "getport" ,
                            "urn:schemas-trickplay-com:service:Controller:1",
                            1,
                            "port",
                            port.str().c_str() );

                    r->ActionResult = response;

                    r->ErrCode = UPNP_E_SUCCESS;
                }
            }
            break;

#if 0

        case UPNP_CONTROL_ACTION_COMPLETE:
            break;

        case UPNP_CONTROL_GET_VAR_REQUEST:
            break;

        case UPNP_CONTROL_GET_VAR_COMPLETE:
            break;
#endif

        default:
            break;
    }

    return 0;
}