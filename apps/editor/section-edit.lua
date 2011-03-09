
-- This gets called once - when the section is about to be shown for
-- the first time.

return
function( section )

--    dofile("editor.lua")

    local ui = section.ui
    local assets = ui.assets
    local factory = ui.factory

    ---------------------------------------------------------------------------

    local TOP_APP_COUNT = 3
    
    
    -- The list of focusable items in the dropdown        
        
    local section_items = {}
    
        
    ---------------------------------------------------------------------------
    -- Build the initial UI for the section
    ---------------------------------------------------------------------------
     local dropdown_map =
     {
     	["Undo".."\t\t\t".."[U]"]   = function() editor.undo() input_mode = S_SELECT end,
     	["Redo".."\t\t\t".."[E]"]   = function() editor.redo() input_mode = S_SELECT end,
     	["Text".."\t\t\t\t".."[T]"]   = function() editor.text() input_mode = S_SELECT end,
     	["Image".."\t\t\t".."[I]"]   = function() input_mode = S_SELECT editor.image()  end,
     	["Rectangle".."\t\t".."[R]"]   = function() input_mode = S_RECTANGLE end,
     	["Video".."\t\t"..""]   = function() input_mode = S_SELECT editor.video() end,
     	["Timeline".."\t\t\t".."[J]"]   = function() input_mode = S_SELECT local tl = widget.timeline() screen:add(tl)
						     screen:find_child("timeline").extra.show = true end,
     	["Timeline Hide".."\t\t".."[J]"]   = function() screen:find_child("timeline"):hide() 
							screen:find_child("timeline").extra.show = false end,
     	["Timeline Show".."\t".."[J]"]   = function() screen:find_child("timeline"):show() 
						      screen:find_child("timeline").extra.show = true end,
     	["Widgets ...".."\t\t".."[W]"]   = function() input_mode = S_SELECT editor.widgets()  end,
     	["Clone".."\t\t\t".."[C]"]   = function() editor.clone() input_mode = S_SELECT end,
     	["Delete".."\t\t     ".."[Del]"]   = function() editor.delete() input_mode = S_SELECT end,
     	["Group".."\t\t\t".."[G]"]   = function() editor.group() input_mode = S_SELECT end,
     	["UnGroup".."\t\t\t"..""]   = function() editor.ugroup() input_mode = S_SELECT end
     }
    local function build_dropdown_ui()
    
        local group = section.dropdown
        
        local TOP_PADDING = 48
        local BOTTOM_PADDING = 12
        
        local space = group.h - ( TOP_PADDING + BOTTOM_PADDING )
        local items_height = 0
    
    
        local f_undo   = factory.make_text_menu_item( assets , ui.strings[ "Undo".."\t\t\t".."[U]" ] )
        local f_redo   = factory.make_text_menu_item( assets , ui.strings[ "Redo".."\t\t\t".."[E]" ] )
        local f_text   = factory.make_text_menu_item( assets , ui.strings[ "Text".."\t\t\t\t".."[T]" ] )
        local f_image  = factory.make_text_menu_item( assets , ui.strings[ "Image".."\t\t\t".."[I]" ] )
        local f_rect   = factory.make_text_menu_item( assets , ui.strings[ "Rectangle".."\t\t".."[R]" ] )
        local f_video  = factory.make_text_menu_item( assets , ui.strings[ "Video".."\t\t".."" ] )
        local f_widget = factory.make_text_menu_item( assets , ui.strings[ "Widgets ...".."\t\t".."[W]" ] )
        local f_timeline = factory.make_text_menu_item( assets , ui.strings[ "Timeline".."\t\t\t".."[J]" ] )
        local f_clone  = factory.make_text_menu_item( assets , ui.strings[ "Clone".."\t\t\t".."[C]" ] )
        local f_delete = factory.make_text_menu_item( assets , ui.strings[ "Delete".."\t\t     ".."[Del]" ] )
        local f_group  = factory.make_text_menu_item( assets , ui.strings[ "Group".."\t\t\t".."[G]" ] )
        local f_ugroup = factory.make_text_menu_item( assets , ui.strings[ "UnGroup".."\t\t\t".."" ] )
        
    
        table.insert( section_items , f_undo )
        table.insert( section_items , f_redo )
        table.insert( section_items , f_text )
        table.insert( section_items , f_image )
        table.insert( section_items , f_rect )
        table.insert( section_items , f_video )
        table.insert( section_items , f_widget )
        table.insert( section_items , f_timeline )
        table.insert( section_items , f_delete)
        table.insert( section_items , f_clone )
        table.insert( section_items , f_group )
        table.insert( section_items , f_ugroup )
        
	for _,item in ipairs( section_items ) do
	     item.reactive = true
	     if (item.text ~= "INSERT :                   ") then 
             function item:on_button_down(x,y,button,num_clicks)
        	if item.on_activate then
	    		item:on_focus_out()
            		animate_out_dropdown()
            		item:on_activate()
            		screen.grab_key_focus(screen)
			
        	end
		return true 
	     end
             if item:find_child("caption") then
                local dropmenu_item = item:find_child("caption")
                --dropmenu_item.reactive = true
                function dropmenu_item:on_button_down(x,y,button,num_clicks)
		        local s= ui.sections[ui.focus]
        		ui.button_focus.position = s.button.position
        		ui.button_focus.opacity = 0
            		animate_out_dropdown()
                        if(dropdown_map[dropmenu_item.text]) then dropdown_map[dropmenu_item.text]() end
                        return true
            		--screen.grab_key_focus(screen)
                end
             end
             end
       end

        items_height = items_height + f_undo.h + f_redo.h + f_text.h + f_image.h + f_rect.h + f_video.h + f_timeline.h + f_widget.h + f_delete.h + f_clone.h + f_group.h -- + f_insert.h
        

        f_rect.extra.on_activate =
            function()
		input_mode = S_RECTANGLE
            end
        
        f_text.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.text()
            end
        f_image.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.image()
            end
        f_video.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.video()
            end
        f_timeline.extra.on_activate =
            function()
		input_mode = S_SELECT
                local caption = f_timeline:find_child("caption").text
		if(dropdown_map[caption]) then dropdown_map[caption]() end
            end
        f_widget.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.widgets()
            end
        f_undo.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.undo()
            end
        
        f_redo.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.redo()
            end
        f_group.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.group()
            end
        f_ugroup.extra.on_activate =
            function()
		input_mode = S_SELECT
		editor.ugroup()
            end
        f_delete.extra.on_activate =
            function()
		editor.delete()
		input_mode = S_SELECT
            end
        f_clone.extra.on_activate =
            function()
		editor.clone()
		input_mode = S_SELECT
            end
        
        -- This spaces all items equally.
        -- TODO: If there are less than 3 app tiles, it will be wrong.
        
        local margin = ( space - items_height ) / ( # section_items - 1 )
        
        local y = TOP_PADDING
        
        for _ , item in ipairs( section_items ) do
        
            item.x = ( group.w - item.w ) / 2
            item.y = y
            
            y = y + item.h -5.45 -- + margin
            
            group:add( item )
            
        end
        
    end
    
    ---------------------------------------------------------------------------
    -- Called each time the drop down is about to be shown
    ---------------------------------------------------------------------------

    function section.on_show( section )
    end
    
    ---------------------------------------------------------------------------
    
    local function move_focus( delta )
    
        local unfocus = section_items[ section.focus ]
        local focus = section_items[ section.focus + delta ]
        local next_focus = section.focus + delta 
	local prev_focus 

	if not focus then
            if section.focus + delta == 0 then
                if unfocus then
                    unfocus:on_focus_out() 
                end
                ui:on_exit_section()
            end
            return
        end

        while focus.reactive == false do 
	      next_focus = next_focus + delta 
	      focus = section_items[next_focus]
	      if focus == nil then 
	          next_focus = 1 
		  focus = section_items[ next_focus ]
		  if(delta < 0) then 
		       while focus ~= nil do 
		       	    if focus.reactive == true then 
				prev_focus = focus
		            end 
			    next_focus = next_focus + 1
			    focus = section_items[next_focus]
		       end 
		       focus = prev_focus
		  end
	      end 
	end 
        
        if unfocus then
            unfocus:on_focus_out()
        end
        
        section.focus = next_focus
    
        focus:on_focus_in()
    end
    
    local function activate_focused()
    
        local focused = section_items[ section.focus ]
        
        if focused and focused.on_activate then
	    focused:on_focus_out()
            animate_out_dropdown()
            focused:on_activate()
        end
    
    end
    
    
    local key_map =
    {
        [ keys.Up     ] = function() move_focus( -1 ) end,
        [ keys.Down   ] = function() move_focus( 1  ) end,
        [ keys.Return ] = activate_focused,
    }

    ---------------------------------------------------------------------------
    -- Called when the section is entered, by pressing down from the
    -- main menu bar
    ---------------------------------------------------------------------------
    
    function section.on_enter( section )
    
        section.focus = 0
        
        move_focus( 1 )
        
        section.dropdown:grab_key_focus()
        
        section.dropdown.on_key_down =
        
            function( section , key )
		local s= ui.sections[ui.focus]
        	ui.button_focus.position = s.button.position
        	ui.button_focus.opacity = 0

                local f = key_map[ key ]
                if f then
                    f()
                end
		return true 
            end
    end

    ---------------------------------------------------------------------------
    -- Called when the user presses enter on this section's menu button
    ---------------------------------------------------------------------------
    
    function section.on_default_action( section )
    
        
        return true
    
    end
    
    
    build_dropdown_ui()
end