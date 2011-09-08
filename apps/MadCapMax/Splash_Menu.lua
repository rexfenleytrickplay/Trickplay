Splash_Menu = Group{}


local continue, continue_hl, start_new, start_new_hl, help, bg
local index = 1
local splash_path_dir = "menus/splash/"
local enter_press = {
    function() --[[DOES NOTHING]] end,
    function()
        
       
        launch_lvl[1](Splash_Menu)
        
    end,
}

local focus_on, help_focused

gamestate:add_state_change_function(
    function()
        Splash_Menu:load_assets(layers.menus)
    end,
    nil,"SPLASH"
)
local prog  = Rectangle{x = 40, y = screen_h - 100, w=10,         h = 30,color="f69024dd"}
local track = Rectangle{x = 40, y = screen_h - 100, w=screen_w-80,h = 30,color="00000066"}

Splash_Menu:add(track,prog)
local num_assets, num_loaded
function Splash_Menu.set_progress(amt)
    help:unparent()
    help = nil
    continue:unparent()    
    continue_hl:unparent() 
    start_new:unparent()   
    start_new_hl:unparent()
    continue = nil
    continue_hl = nil
    start_new = nil
    start_new_hl = nil
    collectgarbage("collect")
    
    if type(amt) ~= "number" then
        
        error("must pass a number for the number of assets",2)
        
    end
    
    track:raise_to_top()
    track:show()
    prog:raise_to_top()
    prog:show()
    
    num_assets = amt
    num_loaded = 0
end
function Splash_Menu:inc_progress()

    num_loaded = num_loaded + 1
    
    if num_loaded > num_assets then
        
        error("miscalculation in progress",2)
        
    elseif num_loaded == num_assets then
        
        bg:unparent()
        bg = nil
        Splash_Menu:unparent()
        
        collectgarbage("collect")
        
        
        gamestate:change_state_to("ACTIVE")
        
    end
    
    prog.w = num_loaded/num_assets*track.w
    
end

function Splash_Menu:load_assets(parent)
    
    index = 2
    
    bg   = Image{src = assets_path_dir..splash_path_dir.."splash.jpg",scale = {4/3,4/3}}
    help = Image{src = assets_path_dir..splash_path_dir.."how-to-card.png", x=500, y=970}
    --play = Image{src = assets_path_dir..splash_path_dir.."splash-arrow-highlight.png",scale = {4/3,4/3}, x=1064,y=568}
    continue     = Image{src = assets_path_dir..splash_path_dir.."splash-continue-btn-yellow.png", x=  50, y=500}
    continue_hl  = Image{src = assets_path_dir..splash_path_dir.."splash-continue-btn-orange.png", x=  50, y=500,opacity = 0}
    start_new    = Image{src = assets_path_dir..splash_path_dir.."splash-new-btn-yellow.png",      x=1400, y=500}
    start_new_hl = Image{src = assets_path_dir..splash_path_dir.."splash-new-btn-orange.png",      x=1400, y=500,opacity = 0}
    
    continue_hl.flash  = make_flash_anim(    continue_hl, function() return index ~= 1 or help_focused end )
    start_new_hl.flash = make_flash_anim(    start_new_hl, function() return index ~= 2 or help_focused end )
    
    
    if not settings.save_game then
        
        continue.opacity = 255*.25
        
    end
    
    local help_y_up = Interval(970,200)
    local help_y_dn = Interval(200,970)
    local slide_up_help = {
        duration = .3,
        on_step = function(s,p)
            help.y = help_y_up:get_value(p)
        end
    }
    local slide_down_help = {
        duration = .3,
        on_step = function(s,p)
            help.y = help_y_dn:get_value(p)
        end
    }
    --[[
    focus_out = {
        function()
            
            if Animation_Loop:has_animation(slide_down_help) then
                
                Animation_Loop:delete_animation(slide_down_help)
                
            end
            
        end,
        function()
            
            if Animation_Loop:has_animation(slide_up_help) then
                
                Animation_Loop:delete_animation(slide_up_help)
                
            end
            
        end,
    }
    focus_on = {
        function()
            print(1)
            if  not Animation_Loop:has_animation(flash_play_hl) then
                print(2)
                Animation_Loop:add_animation(flash_play_hl)
            end
            
            help_y_dn.from = help.y
            
            Animation_Loop:add_animation(slide_down_help)
            
        end,
        function()
            
            help_y_up.from = help.y
            
            Animation_Loop:add_animation(slide_up_help)
            
        end,
    }
    --]]
    help_focused = false
    focus_on = {
        function()
            
            if  not Animation_Loop:has_animation(continue_hl.flash) then
                Animation_Loop:add_animation(continue_hl.flash)
            end
            
        end,
        function()
            
            if  not Animation_Loop:has_animation(start_new_hl.flash) then
                Animation_Loop:add_animation(start_new_hl.flash)
            end
            
        end,
    }
    
    help_focus_on = function()
        if Animation_Loop:has_animation(slide_down_help) then
            
            Animation_Loop:delete_animation(slide_down_help)
            
        end
        
        Animation_Loop:add_animation(slide_up_help)
    end
    
    help_focus_out = function()
        if Animation_Loop:has_animation(slide_up_help) then
            
            Animation_Loop:delete_animation(slide_up_help)
            
        end
        
        Animation_Loop:add_animation(slide_down_help)
    end
    
    dolater(focus_on[index])
    
    Splash_Menu.opacity = 255
    
    Splash_Menu:add(bg,help,continue,continue_hl,start_new,start_new_hl)
    parent:add(Splash_Menu)
    
    Splash_Menu:grab_key_focus()
end

local left_i = settings.save_game and 1 or 2
local Splash_keys = {
    [keys.Left] = function()
        
        if help_focused then
            
            help_focused = false
            
            help_focus_out()
            
            index = left_i
            
            focus_on[index]()
            
        elseif index ~= left_i then
            
            --focus_out[index]()
            
            index = index - 1
            
            focus_on[index]()
            
        end
        
    end,
    [keys.Right] = function()
        
        if help_focused then
            
            help_focused = false
            
            help_focus_out()
            
            index = 2
            
            focus_on[index]()
            
        elseif index ~= # focus_on then
            
            --focus_out[index]()
            
            index = index + 1
            
            focus_on[index]()
            
        end
        
    end,
    [keys.Down] = function()
        
        if help_focused then
            
            help_focus_out()
            
            focus_on[index]()
            
        else
            
            help_focus_on()
            
        end
        
        help_focused = not help_focused
        
    end,
    [keys.OK] = function()
        
        enter_press[index]()
        
    end,
}
Splash_keys[keys.Up] = Splash_keys[keys.Down]

function Splash_Menu:on_key_down(k)
    
    if Splash_keys[k] then Splash_keys[k]() end
    
    return true
    
end

return Splash_Menu