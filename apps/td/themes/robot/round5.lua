wave = {
			money = 60,
	
			-- Wave 1
			{
				{
					{name = "MediumCreep"},
					size = 10,
					speed = 3,
				},
				size = 10,
			},
			
			-- Wave 2
			{
				{
					{name = "SlowCreep"},
					{name = "MediumCreep"},
					size = 20,
					speed = 2.0,
				},
				size = 20,
			},
			
			-- Wave 3
			{
				{
					{name = "NormalCreep"},
					size = 10,
					speed = 2.5,
					buffs = {hp = 1, speed = 1.5},
				},
				{
					{name = "FlyingCreep"},
					size = 15,
					speed = 2.0,
				},
				size = 25,
			},
		
			-- Wave 5
			{
				{
					{name = "NormalCreep"},
					size = 10,
					speed = 1.5,
					buffs = {hp = 1.3, speed = 1.5},
				},
				{
					{name = "MediumCreep"},
					size = 10,
					speed = 1.5,
				},
				size = 20,
			},
			
			-- Wave 4
			{
				{
					{name = "HardCreep"},
					size = 15,
					speed = 2.0,
				},
				size = 15,
			},

			-- Wave 5
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
			
			-- Wave 7
			{
				{
					{name = "FlyingCreep"},
					size = 25,
					speed = 0.6,
					buffs = {hp = 3},
				},
				size = 25,
			},
			
			-- Wave 8

			{
				{
					{name = "NormalCreep"},
					{name = "HardCreep"},
					size = 20,
					speed = 1.0,
				},
				size = 20,
			},
			
			-- Wave 9
			{
				{
					{name = "MediumCreep"},
					{name = "FlyingCreep"},
					size = 20,
					speed = 1.0,
				},
				size = 20,
			},
		}
return wave