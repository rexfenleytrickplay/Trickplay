TutorialController = Class(Controller, function(self, view, ...)
    self._base.init(self, view, Components.TUTORIAL)
    
    local controller = self
    model = view:get_model()
    
    local keyTable = {
        [keys.Up] = function(self) end,
        [keys.Down] = function(self) model:set_active_component(Components.CHARACTER_SELECTION) self:get_model():notify() end,
        [keys.Left] = function(self) self:move(Directions.LEFT) end,
        [keys.Right] = function(self) self:move(Directions.RIGHT) end,
        [keys.Return] = function(self) model:set_active_component(Components.CHARACTER_SELECTION) self:get_model():notify() end,
    }
    
    function self:on_key_down(k)
        print("Tutorial on_key_down")
        if keyTable[k] then
            keyTable[k](self)
        end
    end
    
    -- Position in tutorial
    local p = 0 -- Previous slide
    local c = 1 -- Current slide
    local n = 2 -- Next slide

    function self:move(dir)
        screen:grab_key_focus()
        
        if(0 ~= dir[1]) then
        
            local new_c = c + dir[1]
            local lower, upper = view:getBounds()
            if new_c >= lower and new_c <= upper then
                p = p + dir[1]
                c = c + dir[1]
                n = n + dir[1]
            end
        
        elseif(0 ~= dir[2]) then
        
        end
        
        self:get_model():notify()
    end
    
    function self:update()
        if model:get_active_component() == Components.TUTORIAL then
            view:update(p, c, n)
        end
    end
end)