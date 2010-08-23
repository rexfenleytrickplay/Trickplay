CharacterSelectionController = Class(Controller,function(self, view, ...)
   self._base.init(self, view, Components.CHARACTER_SELECTION)

   local controller = self
   model = view:get_model()

   local CharacterSelectionGroups = {
      TOP = 1,
      BOTTOM = 2,
   }
   local SubGroups = {
      LEFT = 1,
      LEFT_MIDDLE = 2,
      MIDDLE = 3,
      RIGHT_MIDDLE = 4,
      RIGHT = 5
   }

   local GroupSize = 0
   for k, v in pairs(CharacterSelectionGroups) do
      GroupSize = GroupSize + 1
   end
   local SubSize = 0
   for k,v in pairs(SubGroups) do
      SubSize = SubSize + 1
   end

   -- the default selected index
   local selected = CharacterSelectionGroups.BOTTOM
   local subselection = SubGroups.LEFT
   assert(selected)
   assert(subselection)
   --the number of the current player selecting a seat
   local playerCounter = 0

   local function start_a_game()
      --make sure last dog selected does not continue to glow
      for _,v in ipairs(DOG_GLOW) do
         v.opacity = 0
      end
      model:set_active_component(Components.GAME)
      model:notify()
      game:initialize_game{
         sb=SMALL_BLIND,
         bb=BIG_BLIND,
         endowment=INITIAL_ENDOWMENT,
         players=model.players
      }
      old_on_key_down = nil
   end

   local CharacterSelectionCallbacks = {
      [CharacterSelectionGroups.TOP] = {},
      [CharacterSelectionGroups.BOTTOM] = {
         [SubGroups.LEFT_MIDDLE] = function()
            if playerCounter >= 2 then
               start_a_game()
            end
         end,
         [SubGroups.MIDDLE] = function() exit() return end,
         [SubGroups.RIGHT_MIDDLE] = function()
            print("starting tutorial")
            model:set_active_component(Components.TUTORIAL)
            self:get_model():notify()
         end
      },
   }

   function self:getPosition(i, j)
      
      local sel = selected
      local subsel = subselection
      if i and j then
          sel = i
          subsel = j
      end
      
      local num
      
      if sel == 2 and subsel == 1 then
         num = 1
      elseif sel == 1 then
         num = 1 + subsel
      elseif sel == 2 and subsel == 5 then
         num = 6
      else
         error("error selecting position", 2)
      end

      return num
      
   end

   local function setCharacterSeat()

      --instantiate the player
      local pos = self:getPosition()
      if(model.positions[pos]) then return end
      local isHuman = false
      if(playerCounter == 0) then
         isHuman = true
      end
      
      args = {
         isHuman = isHuman,
         number = playerCounter + 1,
         table_position = pos,
         position = model.default_player_locations[ self:getPosition() ],
         chipPosition = model.default_bet_locations[ self:getPosition() ],
         endowment = INITIAL_ENDOWMENT
      }

      -- insertion point
      local i = 1
      while i <= #model.players do
         if pos < model.players[i].table_position then
            break
         end
         i = i+1
      end
      table.insert(model.players, i, Player(args))
      model.positions[pos] = true
      model.currentPlayer = playerCounter

      playerCounter = playerCounter + 1
      self:get_model():notify()
   end

   local CharacterSelectionKeyTable = {
      [keys.Up] = function(self) self:move_selector(Directions.UP) end,
      [keys.Down] = function(self) self:move_selector(Directions.DOWN) end,
      [keys.Left] = function(self) self:move_selector(Directions.LEFT) end,
      [keys.Right] = function(self) self:move_selector(Directions.RIGHT) end,
      [keys.Return] =
         function(self)
            if(CharacterSelectionCallbacks[selected][subselection]) then
               CharacterSelectionCallbacks[selected][subselection]()
            else
               setCharacterSeat()
               if(playerCounter >= 6) then
                  start_a_game()
               end
            end
         end
   }

   function self:on_key_down(k)
      if CharacterSelectionKeyTable[k] then
         CharacterSelectionKeyTable[k](self)
      end
   end

   function self:get_selected_index()
      return selected
   end

   function self:get_subselection_index()
      return subselection
   end

   local function check_for_valid(dir)
      if (CharacterSelectionGroups.TOP == selected) and
         (SubGroups.RIGHT == subselection) then
            subselection = SubGroups.RIGHT_MIDDLE 
      elseif CharacterSelectionGroups.BOTTOM == selected then
         if(0 ~= dir[2]) then
            if(subselection >= SubGroups.MIDDLE) then
               subselection = subselection + 1
            elseif(subselection == SubGroups.LEFT_MIDDLE and playerCounter < 2) then
               subselection = 1
            end
         elseif (0 ~= dir[1]) and (playerCounter < 2) and
            (subselection == SubGroups.LEFT_MIDDLE) then
               subselection = subselection + dir[1]
         end
      end
   end

   function self:move_selector(dir)
      screen:grab_key_focus()
      if(0 ~= dir[1]) then
         local new_selected = subselection + dir[1]
         if 1 <= new_selected and SubSize >= new_selected then
            subselection = new_selected
         end
         elseif(0 ~= dir[2]) then
         local new_selected = selected + dir[2]
         if 1 <= new_selected and GroupSize >= new_selected then
            selected = new_selected
         end
      end
      check_for_valid(dir)
      self:get_model():notify()
   end

end)