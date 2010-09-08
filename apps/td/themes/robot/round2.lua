wave = {
	
	money = 10,
	-- Wave 1
	{
		{
			{name = "SlowCreep"},
			size = 1,
			speed = 2,
			buffs = {hp = 1},
		},
		size = 5,
	},
	
	 -- Wave 2
	{
		{
			{name = "SlowCreep"},
			size = 1,
			speed = 1.5,
			buffs = {hp = 1.25, speed = 1.25},
		},
		size = 5,
	},
	--[[
	 -- Wave 3
	{
		{
			{name = "SlowCreep"},
			size = 15,
			speed = 1.5,
			buffs = {hp = 1.5, speed = 1.5},
		},
		{
			{name = "MediumCreep"},
			size = 5,
			speed = 2,  
		},
		size = 20,
	},
	
	-- Wave 4
	{
		{
			{name = "SlowCreep"},
			{name = "MediumCreep"},
			size = 20,
			speed = 1.5,
			buffs = {hp = 1, speed = 1},
		},
		size = 20,
	},
	
	-- Wave 5
	{
		{
			{name = "MediumCreep"},
			size = 10,
			speed = 1.5,
			buffs = {hp = 1.5, speed = 1.2},
		},
		size = 10,
	},
	
	-- Wave 6
	{
		{
			{name = "MediumCreep"},
			size = 10,
			speed = 1.5,
			buffs = {hp = 1.5, speed = 1.2},
		},
		{
			{name = "NormalCreep"},
			{name = "NormalCreep"},
			size = 30,
			speed = 1.5,
			buffs = {hp = 1.5, speed = 1.2},
		},
		size = 40,
	},
	
	-- Wave 7
	{
		{
			{name = "MediumCreep"},
			{name = "MediumCreep"},
			size = 20,
			speed = 2,
		},
		size = 20,
	},
	
	-- Wave 8
	{
		{
			{name = "NormalCreep"},
			{name = "MediumCreep"},
			size = 20,
			speed = 1.5,
		},
		{
			{name = "HardCreep"},
			size = 2,
			speed = 2,
		},
		size = 22,
	},
	
	-- Wave 9
	{
		{
			{name = "MediumCreep"},
			size = 20,
			speed = 1,
			buffs = { hp = 2 }
		},
		{
			{name = "HardCreep"},
			size = 5,
			speed = 1.5,
		},
		size = 25,
	},
	
	-- Wave 10
	{
		{
			{name = "BossCreep"},
			size = 1,
			buffs = { hp = .25 }
		},
		size = 1,
	},]]
}
	
return wave