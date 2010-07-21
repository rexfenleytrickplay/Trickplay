Tower = {}

function Tower:new(args)
	local towerType = args.towerType
	local damage = args.damage
	local range = args.range
	local cost = args.cost
	local direction = args.direction
	local cooldown = args.cooldown
	local towerImage = AssetLoader:getImage("normalRobot",{ clip={0,0,60,60} })
	local isAttacking = false
	local bullets = {}
	local tower_elapsed_time = 0
	
	local object = {
		towerType = towerType,
		damage = damage,
		range = range,
		direction = direction,
		cooldown = cooldown,
		cost = cost,
		towerImage = towerImage,
		isAttacking = isAttacking,
		bullets = bullets,
		tower_elapsed_time = tower_elapsed_time
   }
   setmetatable(object, self)
   self.__index = self
   return object
end

function Tower:destroy()
	self.towerImage.opacity = 0
end

function Tower:attack()

end

function Tower:render(seconds, creeps)
	self.tower_elapsed_time = self.tower_elapsed_time + seconds
	local creep_in_range = false	
	local creep_to_kill
	
	local current
	
	for i = 1, #creeps do
		if (creeps[i].creepImage.x > self.x - self.range and creeps[i].creepImage.x < self.x + self.range
				and creeps[i].creepImage.y > self.y - self.range and creeps[i].creepImage.y < self.y + self.range and creeps[i].hp ~=0) then
			print ("creep "..i.." in range")
			print(self.x, self.y)
			
			current = i		
		
			creep_in_range = true
			creeps[i].hp = creeps[i].hp - self.damage
			if (creeps[i].hp <=0) then creeps[i].hp =0 end
			break
		end
	end
	
	if creeps[current].creepImage.x > self.x then 
		self.towerImage.x = self.x - 60*4
		self.towerImage.clip = { 60*4,0,60,60 }
	end
		
		
	if creeps[current].creepImage.x < self.x then 
		self.towerImage.x = self.x 
		self.towerImage.clip = {0,0,60,60}
	end
	
	if (math.floor(self.tower_elapsed_time) % 2 == 0 and creep_in_range) then
			self.tower_elapsed_time = self.tower_elapsed_time + 1
	end

end
















--			local temp_bullet = Clone { source = bulletImage, x = self.towerImage.x, y = self.towerImage.y }
--			screen:add(temp_bullet)
--			table.insert(self.bullets,temp_bullet)
			

	--[[for k,v in pairs(self.bullets) do
		v:animate {duration = 500, x = x_velocity, y = y_velocity}
		if (v.x <= -50) then
			v.x = -50
		end
	end]]
	
