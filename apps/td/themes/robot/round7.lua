wave = {
			money = 75,
	
			-- Wave 1
			{
				{
					{name = "MediumCreep"},
					size = 20,
					speed = 1,
				},
				size = 20,
			},
			
			-- Wave 2
			{
				{
					{name = "SlowCreep"},
					{name = "MediumCreep"},
					size = 20,
					speed = 2.0,
					buffs = {hp = 1.5}
				},
				size = 20,
			},
			-- Wave 3
			{
				{
					{name = "HardCreep"},
					size = 20,
					speed = 2.5,
					buffs = {hp = 1, speed = 1.3},
				},
				size = 20,
			},
			
			-- Wave 4
			{
				{
					{name = "MediumCreep"},
					size = 10,
					speed = 2.0,
					buffs = {hp = 1.3, speed = 1.5},
				},
				{
					{name = "HardCreep"},
					size = 10,
					speed = 2.0,
				},
				size = 20,
			},
		
			-- Wave 5
			{
				{
					{name = "HardCreep"},
					size = 10,
					speed = 1.5,
					buffs = {hp = 1.3, speed = 1.0},
				},
				{
					{name = "HardCreep"},
					size = 10,
					speed = 1.5,
					buffs = {speed = 1.5, hp = 0.6}
				},
				size = 20,
			},

			-- Wave 6
			{
				{
					{name = "FlyingCreep"},
					size = 25,
					speed = 0.6,
					buffs = {hp = 2},
				},
				size = 25,
			},

			-- Wave 7
			{
				{
					{name = "HardCreep"},
					size = 15,
					speed = 0.3,
				},
				size = 15,
			},

			-- Wave 8

			{
				{
					{name = "NormalCreep"},
					{name = "MediumCreep"},
					{name = "HardCreep"},
					size = 30,
					speed = 1.0,
				},
				size = 30,
			},
			
			-- Wave 9
			{
				{
					{name = "BossCreep"},
					size = 1,
					speed = 1.0,
					buffs = {hp = 0.5}
				},
				size = 20,
			},
		}
return wave