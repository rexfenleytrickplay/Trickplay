Player = Class(function(player, args, ...)
   player.isHuman = false
   player.number = 0
   player.bet = model.bet.DEFAULT_BET
   player.money = 800
   player.position = false
   player.table_position = nil
   player.chipPosition = nil
   for k,v in pairs(args) do
      player[k] = v
   end
   
   --[[
   function player:createMoneyChips()
      
      player.moneyChips = chipCollection()
      player.moneyChips.group.position = {player.chipPosition[1], player.chipPosition[2]}
      player.moneyChips:set(player.money)
      player.moneyChips:arrange(55, 5)
      screen:add(player.moneyChips.group)
      
   end
   --]]
   
   function player:createBetChips()
      
      player.betChips = chipCollection()
      player.betChips.group.position = {player.chipPosition[1], player.chipPosition[2]}
      player.betChips:set(player.bet)
      player.betChips:arrange(55, 5)
      screen:add(player.betChips.group)
      
   end

   ---
   -- @param hole an array of two hole cards
   -- @param community_cards
   -- @param call_bet the bet you need to make in order to call
   -- @param position  early, middle, late, whatever
   -- @param min_raise the minimum raise, so values of bet between
   -- call_bet+1 and call_bet+min_raise-1 are invalid
   -- @param current_bet the size of the bet currently in front of the
   -- player for the betting round
   -- @param pot current size of pot
   -- @param round
   -- @returns fold boolean  true if player should fold
   -- @returns bet number  quantity of bet, if fold then bet should be 0
   --function player:get_move(hole, community_cards, position, call_bet, min_raise, current_bet, pot, round)
   function player:get_move(state)
      -- TODO: pass in real position, right now position is placeholder data cause it's unclear how to calculate position.
      local fold = false
      -- local bet = call_bet
      -- local r = math.random(10)
      -- -- if r == 1 then
      -- --    return true, 0
      -- -- else
      -- --    return fold, 10
      -- -- end
      -- if true or hole[1].rank == hole[2].rank or hole[1].rank.num>11 or hole[2].rank.num > 11 then
      --    return false, 10
      -- else
      --    return true, 0
      -- end
      return false, state:get_call_bet()
   end
   
   player.status = PlayerStatusView(model, nil, player)
   player.status:initialize()
   assert(player.status)

end)
