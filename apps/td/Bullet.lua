Bullet = {}

function Bullet:new(args, creep, rotation, damage)

	--print(game.board.theme.themeName.."Bullet"..args.id)

	local object = {
		timer = Stopwatch(),
		image = AssetLoader:getImage(game.board.theme.themeName.."Bullet"..args.id,{z = 4} ),
		frames = args.frames,
		damage = damage,
		time = .2,
		speed = args.speed,
		creep = creep,
	}
	
	--object.image.z_rotation = { rotation, object.image.w/2, object.image.h/2}
	
	--screen:add(AssetLoader:getImage(game.board.theme.themeName.."Bullet"..args.id,{z = 10, x=200, y=200}))
	
	
	if object.frames then object.length = object.image.w/object.frames else object.length = object.image.w end
	
	-- Animate the bullet if it has frames
	if args.frames then object.animation = true end
	
	--print(object.image, "!")
	
	object.timer:start()
	
	setmetatable(object, self)
	self.__index = self
	return object
end

function Bullet:render(seconds)

	if self.animation then
	
		--print(1)

		for i=1, self.frames do
			if self.timer.elapsed_seconds < ( 1/self.frames ) * i * self.time and self.timer.elapsed_seconds > ( 1/self.frames) * (i-1) * self.time then
				self.image.x = - self.length * (i-1)
			end
		end
		
		--print(2)

		if self.timer.elapsed_seconds > self.time then
			self.imageGroup:remove(self.image)
			self.imageGroup.parent:remove(self.imageGroup)
			self = nil
			return
		end
		
		--print(3)
		
	end
	

	
	if self.speed then
		
		local xtarget = self.creep.creepGroup.x + self.creep.creepImageGroup.x + ( self.creep.creepImage.w/self.creep.frames ) / 2
		local ytarget = self.creep.creepGroup.y + self.creep.creepImageGroup.y + ( self.creep.creepImage.h ) / 2
	
		--print(self.creep.creepGroup.x, self.creep.creepImage.x, self.creep.creepImageGroup.x)
	
		--local d = math.sqrt( (self.creep.creepGroup.x-self.imageGroup.x)^2 + (self.creep.creepGroup.y-self.imageGroup.y)^2 )
		--print(d)
		
		local dx = self.imageGroup.x - xtarget
		local dy = self.imageGroup.y - ytarget
		
		--local sx = dx / math.abs(dx)
		--local sy = dy / math.abs(dy)
		
		local xratio = dx/( math.abs(dx) + math.abs(dy) )
		local yratio = dy/( math.abs(dx) + math.abs(dy) )
		
		self.imageGroup.x = self.imageGroup.x - xratio * seconds * self.speed
		self.imageGroup.y = self.imageGroup.y - yratio * seconds * self.speed
		
		local pastx
		local pasty
		
		if dx > 0 then
			if dx < 20 then
				pastx = true
			end
		elseif dx < 0 then
			if dx > -20 then
				pastx = true
			end
		end
		
		if dy > 0 then
			if dy < 20 then
				pasty = true
			end
		elseif dy < 0 then
			if dy > -20 then
				pasty = true
			end
		end
		
		if pastx or pasty or self.imageGroup.x > 1920 or self.imageGroup.x < 0 or self.imageGroup.y > 1080 or self.imageGroup.y < 0 or self.creep.hp <= 0 then 
			--print(dx, dy, self.imageGroup.x, self.imageGroup.y)
			if self.sound then game.bulletSounds = game.bulletSounds - 1 end
			self.creep.hit = true
			self.creep:getHit(self.damage, 1)
			self.imageGroup:remove(self.image)
			self.imageGroup.parent:remove(self.imageGroup)
			self = nil 
			return 
		end
	
	end

end

--if math.abs(dx) < 20 and dy < 20 or self.imageGroup.x > 1920 or self.imageGroup.x < 0 or self.imageGroup.y > 1080 or self.imageGroup.y < 0 or self.creep.hp <= 0 then 
--math.sqrt( ( (self.creepGroup.x-self.imageGroup.x)(self.creepGroup.x-self.imageGroup.x) ) + ( (self.creepGroup.y-self.imageGroup.y)(self.creepGroup.y-self.imageGroup.y) )  )