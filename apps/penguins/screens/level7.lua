local g = ... 


local bg3 = Clone
	{
		source = b5,
		clip = {0,0,1920,360},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "bg3",
		position = {0,720,0},
		size = {1920,360},
		opacity = 255,
		reactive = true,
	}

bg3.extra.focus = {}

function bg3:on_key_down(key)
	if bg3.focus[key] then
		if type(bg3.focus[key]) == "function" then
			bg3.focus[key]()
		elseif screen:find_child(bg3.focus[key]) then
			if bg3.on_focus_out then
				bg3.on_focus_out()
			end
			screen:find_child(bg3.focus[key]):grab_key_focus()
			if screen:find_child(bg3.focus[key]).on_focus_in then
				screen:find_child(bg3.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

bg3.extra.reactive = true


local bg2 = Clone
	{
		source = b4,
		clip = {0,0,1920,360},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "bg2",
		position = {0,360,0},
		size = {1920,360},
		opacity = 255,
		reactive = true,
	}

bg2.extra.focus = {}

function bg2:on_key_down(key)
	if bg2.focus[key] then
		if type(bg2.focus[key]) == "function" then
			bg2.focus[key]()
		elseif screen:find_child(bg2.focus[key]) then
			if bg2.on_focus_out then
				bg2.on_focus_out()
			end
			screen:find_child(bg2.focus[key]):grab_key_focus()
			if screen:find_child(bg2.focus[key]).on_focus_in then
				screen:find_child(bg2.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

bg2.extra.reactive = true


local bg1 = Clone
	{
		source = b2,
		clip = {0,0,1920,360},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "bg1",
		position = {0,0,0},
		size = {1920,360},
		opacity = 255,
		reactive = true,
	}

bg1.extra.focus = {}

function bg1:on_key_down(key)
	if bg1.focus[key] then
		if type(bg1.focus[key]) == "function" then
			bg1.focus[key]()
		elseif screen:find_child(bg1.focus[key]) then
			if bg1.on_focus_out then
				bg1.on_focus_out()
			end
			screen:find_child(bg1.focus[key]):grab_key_focus()
			if screen:find_child(bg1.focus[key]).on_focus_in then
				screen:find_child(bg1.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

bg1.extra.reactive = true


local player = Clone
	{
		source = pspeed,
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "player",
		position = {0,315,0},
		size = {45,45},
		opacity = 255,
		reactive = true,
	}

player.extra.focus = {}

function player:on_key_down(key)
	if player.focus[key] then
		if type(player.focus[key]) == "function" then
			player.focus[key]()
		elseif screen:find_child(player.focus[key]) then
			if player.on_focus_out then
				player.on_focus_out()
			end
			screen:find_child(player.focus[key]):grab_key_focus()
			if screen:find_child(player.focus[key]).on_focus_in then
				screen:find_child(player.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

player.extra.reactive = true


local image3 = Image
	{
		src = "/assets/igloo.png",
		clip = {0,0,151,88},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "image3",
		position = {1845,273,0},
		size = {151,88},
		opacity = 255,
		reactive = true,
	}

image3.extra.focus = {}

function image3:on_key_down(key)
	if image3.focus[key] then
		if type(image3.focus[key]) == "function" then
			image3.focus[key]()
		elseif screen:find_child(image3.focus[key]) then
			if image3.on_focus_out then
				image3.on_focus_out()
			end
			screen:find_child(image3.focus[key]):grab_key_focus()
			if screen:find_child(image3.focus[key]).on_focus_in then
				screen:find_child(image3.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

image3.extra.reactive = true


local clone4 = Clone
	{
		scale = {1,1,0,0},
		source = image3,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone4",
		position = {1845,992,0},
		size = {151,88},
		opacity = 255,
		reactive = true,
	}

clone4.extra.focus = {}

function clone4:on_key_down(key)
	if clone4.focus[key] then
		if type(clone4.focus[key]) == "function" then
			clone4.focus[key]()
		elseif screen:find_child(clone4.focus[key]) then
			if clone4.on_focus_out then
				clone4.on_focus_out()
			end
			screen:find_child(clone4.focus[key]):grab_key_focus()
			if screen:find_child(clone4.focus[key]).on_focus_in then
				screen:find_child(clone4.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone4.extra.reactive = true


local clone6 = Clone
	{
		scale = {1,1,0,0},
		source = image3,
		x_rotation = {0,0,0},
		y_rotation = {180,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone6",
		position = {75,634,0},
		size = {151,88},
		opacity = 255,
		reactive = true,
	}

clone6.extra.focus = {}

function clone6:on_key_down(key)
	if clone6.focus[key] then
		if type(clone6.focus[key]) == "function" then
			clone6.focus[key]()
		elseif screen:find_child(clone6.focus[key]) then
			if clone6.on_focus_out then
				clone6.on_focus_out()
			end
			screen:find_child(clone6.focus[key]):grab_key_focus()
			if screen:find_child(clone6.focus[key]).on_focus_in then
				screen:find_child(clone6.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone6.extra.reactive = true


local image7 = Image
	{
		src = "/assets/obstacle_1.png",
		clip = {0,0,65,62},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "image7",
		position = {988,361,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

image7.extra.focus = {}

function image7:on_key_down(key)
	if image7.focus[key] then
		if type(image7.focus[key]) == "function" then
			image7.focus[key]()
		elseif screen:find_child(image7.focus[key]) then
			if image7.on_focus_out then
				image7.on_focus_out()
			end
			screen:find_child(image7.focus[key]):grab_key_focus()
			if screen:find_child(image7.focus[key]).on_focus_in then
				screen:find_child(image7.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

image7.extra.reactive = true


local clone8 = Clone
	{
		scale = {1,3,0,0},
		source = image7,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone8",
		position = {822,174,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone8.extra.focus = {}

function clone8:on_key_down(key)
	if clone8.focus[key] then
		if type(clone8.focus[key]) == "function" then
			clone8.focus[key]()
		elseif screen:find_child(clone8.focus[key]) then
			if clone8.on_focus_out then
				clone8.on_focus_out()
			end
			screen:find_child(clone8.focus[key]):grab_key_focus()
			if screen:find_child(clone8.focus[key]).on_focus_in then
				screen:find_child(clone8.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone8.extra.reactive = true


local clone9 = Clone
	{
		scale = {1,3,0,0},
		source = clone8,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone9",
		position = {1360,174,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone9.extra.focus = {}

function clone9:on_key_down(key)
	if clone9.focus[key] then
		if type(clone9.focus[key]) == "function" then
			clone9.focus[key]()
		elseif screen:find_child(clone9.focus[key]) then
			if clone9.on_focus_out then
				clone9.on_focus_out()
			end
			screen:find_child(clone9.focus[key]):grab_key_focus()
			if screen:find_child(clone9.focus[key]).on_focus_in then
				screen:find_child(clone9.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone9.extra.reactive = true


local clone21 = Clone
	{
		scale = {1,1,0,0},
		source = image7,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone21",
		position = {1356,422,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone21.extra.focus = {}

function clone21:on_key_down(key)
	if clone21.focus[key] then
		if type(clone21.focus[key]) == "function" then
			clone21.focus[key]()
		elseif screen:find_child(clone21.focus[key]) then
			if clone21.on_focus_out then
				clone21.on_focus_out()
			end
			screen:find_child(clone21.focus[key]):grab_key_focus()
			if screen:find_child(clone21.focus[key]).on_focus_in then
				screen:find_child(clone21.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone21.extra.reactive = true


local clone22 = Clone
	{
		scale = {1,1,0,0},
		source = clone21,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone22",
		position = {1356,361,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone22.extra.focus = {}

function clone22:on_key_down(key)
	if clone22.focus[key] then
		if type(clone22.focus[key]) == "function" then
			clone22.focus[key]()
		elseif screen:find_child(clone22.focus[key]) then
			if clone22.on_focus_out then
				clone22.on_focus_out()
			end
			screen:find_child(clone22.focus[key]):grab_key_focus()
			if screen:find_child(clone22.focus[key]).on_focus_in then
				screen:find_child(clone22.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone22.extra.reactive = true


local clone23 = Clone
	{
		scale = {1,1,0,0},
		source = clone22,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone23",
		position = {988,422,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone23.extra.focus = {}

function clone23:on_key_down(key)
	if clone23.focus[key] then
		if type(clone23.focus[key]) == "function" then
			clone23.focus[key]()
		elseif screen:find_child(clone23.focus[key]) then
			if clone23.on_focus_out then
				clone23.on_focus_out()
			end
			screen:find_child(clone23.focus[key]):grab_key_focus()
			if screen:find_child(clone23.focus[key]).on_focus_in then
				screen:find_child(clone23.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone23.extra.reactive = true


local grav1 = Image
	{
		src = "/assets/collect_red.png",
		clip = {0,0,64,49},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "grav1",
		position = {1178,422,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

grav1.extra.focus = {}

function grav1:on_key_down(key)
	if grav1.focus[key] then
		if type(grav1.focus[key]) == "function" then
			grav1.focus[key]()
		elseif screen:find_child(grav1.focus[key]) then
			if grav1.on_focus_out then
				grav1.on_focus_out()
			end
			screen:find_child(grav1.focus[key]):grab_key_focus()
			if screen:find_child(grav1.focus[key]).on_focus_in then
				screen:find_child(grav1.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

grav1.extra.reactive = true


local grav2 = Clone
	{
		scale = {1,1,0,0},
		source = grav1,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "grav2",
		position = {800,482,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

grav2.extra.focus = {}

function grav2:on_key_down(key)
	if grav2.focus[key] then
		if type(grav2.focus[key]) == "function" then
			grav2.focus[key]()
		elseif screen:find_child(grav2.focus[key]) then
			if grav2.on_focus_out then
				grav2.on_focus_out()
			end
			screen:find_child(grav2.focus[key]):grab_key_focus()
			if screen:find_child(grav2.focus[key]).on_focus_in then
				screen:find_child(grav2.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

grav2.extra.reactive = true


local clone15 = Clone
	{
		scale = {1,1,0,0},
		source = clone21,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone15",
		position = {600,486,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone15.extra.focus = {}

function clone15:on_key_down(key)
	if clone15.focus[key] then
		if type(clone15.focus[key]) == "function" then
			clone15.focus[key]()
		elseif screen:find_child(clone15.focus[key]) then
			if clone15.on_focus_out then
				clone15.on_focus_out()
			end
			screen:find_child(clone15.focus[key]):grab_key_focus()
			if screen:find_child(clone15.focus[key]).on_focus_in then
				screen:find_child(clone15.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone15.extra.reactive = true


local clone16 = Clone
	{
		scale = {1,1,0,0},
		source = clone15,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone16",
		position = {538,486,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone16.extra.focus = {}

function clone16:on_key_down(key)
	if clone16.focus[key] then
		if type(clone16.focus[key]) == "function" then
			clone16.focus[key]()
		elseif screen:find_child(clone16.focus[key]) then
			if clone16.on_focus_out then
				clone16.on_focus_out()
			end
			screen:find_child(clone16.focus[key]):grab_key_focus()
			if screen:find_child(clone16.focus[key]).on_focus_in then
				screen:find_child(clone16.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone16.extra.reactive = true


local clone17 = Clone
	{
		scale = {1,1,0,0},
		source = clone16,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone17",
		position = {476,486,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone17.extra.focus = {}

function clone17:on_key_down(key)
	if clone17.focus[key] then
		if type(clone17.focus[key]) == "function" then
			clone17.focus[key]()
		elseif screen:find_child(clone17.focus[key]) then
			if clone17.on_focus_out then
				clone17.on_focus_out()
			end
			screen:find_child(clone17.focus[key]):grab_key_focus()
			if screen:find_child(clone17.focus[key]).on_focus_in then
				screen:find_child(clone17.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone17.extra.reactive = true


local clone18 = Clone
	{
		scale = {1,1,0,0},
		source = clone17,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone18",
		position = {414,486,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone18.extra.focus = {}

function clone18:on_key_down(key)
	if clone18.focus[key] then
		if type(clone18.focus[key]) == "function" then
			clone18.focus[key]()
		elseif screen:find_child(clone18.focus[key]) then
			if clone18.on_focus_out then
				clone18.on_focus_out()
			end
			screen:find_child(clone18.focus[key]):grab_key_focus()
			if screen:find_child(clone18.focus[key]).on_focus_in then
				screen:find_child(clone18.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone18.extra.reactive = true


local clone19 = Clone
	{
		scale = {1,1,0,0},
		source = clone18,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone19",
		position = {536,658,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone19.extra.focus = {}

function clone19:on_key_down(key)
	if clone19.focus[key] then
		if type(clone19.focus[key]) == "function" then
			clone19.focus[key]()
		elseif screen:find_child(clone19.focus[key]) then
			if clone19.on_focus_out then
				clone19.on_focus_out()
			end
			screen:find_child(clone19.focus[key]):grab_key_focus()
			if screen:find_child(clone19.focus[key]).on_focus_in then
				screen:find_child(clone19.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone19.extra.reactive = true


local clone20 = Clone
	{
		scale = {1,1,0,0},
		source = clone19,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone20",
		position = {308,658,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone20.extra.focus = {}

function clone20:on_key_down(key)
	if clone20.focus[key] then
		if type(clone20.focus[key]) == "function" then
			clone20.focus[key]()
		elseif screen:find_child(clone20.focus[key]) then
			if clone20.on_focus_out then
				clone20.on_focus_out()
			end
			screen:find_child(clone20.focus[key]):grab_key_focus()
			if screen:find_child(clone20.focus[key]).on_focus_in then
				screen:find_child(clone20.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone20.extra.reactive = true


local clone24 = Clone
	{
		scale = {1,1,0,0},
		source = clone20,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone24",
		position = {352,486,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone24.extra.focus = {}

function clone24:on_key_down(key)
	if clone24.focus[key] then
		if type(clone24.focus[key]) == "function" then
			clone24.focus[key]()
		elseif screen:find_child(clone24.focus[key]) then
			if clone24.on_focus_out then
				clone24.on_focus_out()
			end
			screen:find_child(clone24.focus[key]):grab_key_focus()
			if screen:find_child(clone24.focus[key]).on_focus_in then
				screen:find_child(clone24.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone24.extra.reactive = true


local clone25 = Clone
	{
		scale = {1,1,0,0},
		source = clone24,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone25",
		position = {290,486,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone25.extra.focus = {}

function clone25:on_key_down(key)
	if clone25.focus[key] then
		if type(clone25.focus[key]) == "function" then
			clone25.focus[key]()
		elseif screen:find_child(clone25.focus[key]) then
			if clone25.on_focus_out then
				clone25.on_focus_out()
			end
			screen:find_child(clone25.focus[key]):grab_key_focus()
			if screen:find_child(clone25.focus[key]).on_focus_in then
				screen:find_child(clone25.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone25.extra.reactive = true


local grav3 = Image
	{
		src = "/assets/collect_green.png",
		clip = {0,0,64,49},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "grav3",
		position = {372,970,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

grav3.extra.focus = {}

function grav3:on_key_down(key)
	if grav3.focus[key] then
		if type(grav3.focus[key]) == "function" then
			grav3.focus[key]()
		elseif screen:find_child(grav3.focus[key]) then
			if grav3.on_focus_out then
				grav3.on_focus_out()
			end
			screen:find_child(grav3.focus[key]):grab_key_focus()
			if screen:find_child(grav3.focus[key]).on_focus_in then
				screen:find_child(grav3.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

grav3.extra.reactive = true


local clone26 = Clone
	{
		scale = {1,2,0,0},
		source = clone19,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone26",
		position = {528,838,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone26.extra.focus = {}

function clone26:on_key_down(key)
	if clone26.focus[key] then
		if type(clone26.focus[key]) == "function" then
			clone26.focus[key]()
		elseif screen:find_child(clone26.focus[key]) then
			if clone26.on_focus_out then
				clone26.on_focus_out()
			end
			screen:find_child(clone26.focus[key]):grab_key_focus()
			if screen:find_child(clone26.focus[key]).on_focus_in then
				screen:find_child(clone26.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone26.extra.reactive = true


local clone27 = Clone
	{
		scale = {1,2,0,0},
		source = clone19,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone27",
		position = {528,956,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone27.extra.focus = {}

function clone27:on_key_down(key)
	if clone27.focus[key] then
		if type(clone27.focus[key]) == "function" then
			clone27.focus[key]()
		elseif screen:find_child(clone27.focus[key]) then
			if clone27.on_focus_out then
				clone27.on_focus_out()
			end
			screen:find_child(clone27.focus[key]):grab_key_focus()
			if screen:find_child(clone27.focus[key]).on_focus_in then
				screen:find_child(clone27.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone27.extra.reactive = true


local clone28 = Clone
	{
		scale = {1,2,0,0},
		source = clone26,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone28",
		position = {686,724,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone28.extra.focus = {}

function clone28:on_key_down(key)
	if clone28.focus[key] then
		if type(clone28.focus[key]) == "function" then
			clone28.focus[key]()
		elseif screen:find_child(clone28.focus[key]) then
			if clone28.on_focus_out then
				clone28.on_focus_out()
			end
			screen:find_child(clone28.focus[key]):grab_key_focus()
			if screen:find_child(clone28.focus[key]).on_focus_in then
				screen:find_child(clone28.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone28.extra.reactive = true


local clone29 = Clone
	{
		scale = {1,1,0,0},
		source = clone28,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone29",
		position = {706,846,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone29.extra.focus = {}

function clone29:on_key_down(key)
	if clone29.focus[key] then
		if type(clone29.focus[key]) == "function" then
			clone29.focus[key]()
		elseif screen:find_child(clone29.focus[key]) then
			if clone29.on_focus_out then
				clone29.on_focus_out()
			end
			screen:find_child(clone29.focus[key]):grab_key_focus()
			if screen:find_child(clone29.focus[key]).on_focus_in then
				screen:find_child(clone29.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone29.extra.reactive = true


local clone30 = Clone
	{
		scale = {1,1,0,0},
		source = clone29,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone30",
		position = {724,908,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone30.extra.focus = {}

function clone30:on_key_down(key)
	if clone30.focus[key] then
		if type(clone30.focus[key]) == "function" then
			clone30.focus[key]()
		elseif screen:find_child(clone30.focus[key]) then
			if clone30.on_focus_out then
				clone30.on_focus_out()
			end
			screen:find_child(clone30.focus[key]):grab_key_focus()
			if screen:find_child(clone30.focus[key]).on_focus_in then
				screen:find_child(clone30.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone30.extra.reactive = true


local grav4 = Clone
	{
		scale = {1,1,0,0},
		source = grav2,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "grav4",
		position = {510,750,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

grav4.extra.focus = {}

function grav4:on_key_down(key)
	if grav4.focus[key] then
		if type(grav4.focus[key]) == "function" then
			grav4.focus[key]()
		elseif screen:find_child(grav4.focus[key]) then
			if grav4.on_focus_out then
				grav4.on_focus_out()
			end
			screen:find_child(grav4.focus[key]):grab_key_focus()
			if screen:find_child(grav4.focus[key]).on_focus_in then
				screen:find_child(grav4.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

grav4.extra.reactive = true


local grav5 = Clone
	{
		scale = {1,1,0,0},
		source = grav2,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "grav5",
		position = {580,788,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

grav5.extra.focus = {}

function grav5:on_key_down(key)
	if grav5.focus[key] then
		if type(grav5.focus[key]) == "function" then
			grav5.focus[key]()
		elseif screen:find_child(grav5.focus[key]) then
			if grav5.on_focus_out then
				grav5.on_focus_out()
			end
			screen:find_child(grav5.focus[key]):grab_key_focus()
			if screen:find_child(grav5.focus[key]).on_focus_in then
				screen:find_child(grav5.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

grav5.extra.reactive = true


local clone31 = Clone
	{
		scale = {1,1,0,0},
		source = clone30,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone31",
		position = {1720,884,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone31.extra.focus = {}

function clone31:on_key_down(key)
	if clone31.focus[key] then
		if type(clone31.focus[key]) == "function" then
			clone31.focus[key]()
		elseif screen:find_child(clone31.focus[key]) then
			if clone31.on_focus_out then
				clone31.on_focus_out()
			end
			screen:find_child(clone31.focus[key]):grab_key_focus()
			if screen:find_child(clone31.focus[key]).on_focus_in then
				screen:find_child(clone31.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone31.extra.reactive = true


local clone32 = Clone
	{
		scale = {0.5,0.5,0,0},
		source = clone30,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "clone32",
		position = {1738,1058,0},
		size = {65,62},
		opacity = 255,
		reactive = true,
	}

clone32.extra.focus = {}

function clone32:on_key_down(key)
	if clone32.focus[key] then
		if type(clone32.focus[key]) == "function" then
			clone32.focus[key]()
		elseif screen:find_child(clone32.focus[key]) then
			if clone32.on_focus_out then
				clone32.on_focus_out()
			end
			screen:find_child(clone32.focus[key]):grab_key_focus()
			if screen:find_child(clone32.focus[key]).on_focus_in then
				screen:find_child(clone32.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

clone32.extra.reactive = true


local ggrav3 = Clone
	{
		scale = {1,1,0,0},
		source = grav3,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "ggrav3",
		position = {1248,880,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

ggrav3.extra.focus = {}

function ggrav3:on_key_down(key)
	if ggrav3.focus[key] then
		if type(ggrav3.focus[key]) == "function" then
			ggrav3.focus[key]()
		elseif screen:find_child(ggrav3.focus[key]) then
			if ggrav3.on_focus_out then
				ggrav3.on_focus_out()
			end
			screen:find_child(ggrav3.focus[key]):grab_key_focus()
			if screen:find_child(ggrav3.focus[key]).on_focus_in then
				screen:find_child(ggrav3.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

ggrav3.extra.reactive = true


local ggrav1 = Clone
	{
		scale = {1,1,0,0},
		source = ggrav3,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "ggrav1",
		position = {894,910,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

ggrav1.extra.focus = {}

function ggrav1:on_key_down(key)
	if ggrav1.focus[key] then
		if type(ggrav1.focus[key]) == "function" then
			ggrav1.focus[key]()
		elseif screen:find_child(ggrav1.focus[key]) then
			if ggrav1.on_focus_out then
				ggrav1.on_focus_out()
			end
			screen:find_child(ggrav1.focus[key]):grab_key_focus()
			if screen:find_child(ggrav1.focus[key]).on_focus_in then
				screen:find_child(ggrav1.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

ggrav1.extra.reactive = true


local ggrav2 = Clone
	{
		scale = {1,1,0,0},
		source = ggrav1,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "ggrav2",
		position = {1100,1030,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

ggrav2.extra.focus = {}

function ggrav2:on_key_down(key)
	if ggrav2.focus[key] then
		if type(ggrav2.focus[key]) == "function" then
			ggrav2.focus[key]()
		elseif screen:find_child(ggrav2.focus[key]) then
			if ggrav2.on_focus_out then
				ggrav2.on_focus_out()
			end
			screen:find_child(ggrav2.focus[key]):grab_key_focus()
			if screen:find_child(ggrav2.focus[key]).on_focus_in then
				screen:find_child(ggrav2.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

ggrav2.extra.reactive = true


local rgrav1 = Clone
	{
		scale = {1,1,0,0},
		source = grav5,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "rgrav1",
		position = {944,1022,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

rgrav1.extra.focus = {}

function rgrav1:on_key_down(key)
	if rgrav1.focus[key] then
		if type(rgrav1.focus[key]) == "function" then
			rgrav1.focus[key]()
		elseif screen:find_child(rgrav1.focus[key]) then
			if rgrav1.on_focus_out then
				rgrav1.on_focus_out()
			end
			screen:find_child(rgrav1.focus[key]):grab_key_focus()
			if screen:find_child(rgrav1.focus[key]).on_focus_in then
				screen:find_child(rgrav1.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

rgrav1.extra.reactive = true


local rgrav2 = Clone
	{
		scale = {1,1,0,0},
		source = rgrav1,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "rgrav2",
		position = {1094,930,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

rgrav2.extra.focus = {}

function rgrav2:on_key_down(key)
	if rgrav2.focus[key] then
		if type(rgrav2.focus[key]) == "function" then
			rgrav2.focus[key]()
		elseif screen:find_child(rgrav2.focus[key]) then
			if rgrav2.on_focus_out then
				rgrav2.on_focus_out()
			end
			screen:find_child(rgrav2.focus[key]):grab_key_focus()
			if screen:find_child(rgrav2.focus[key]).on_focus_in then
				screen:find_child(rgrav2.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

rgrav2.extra.reactive = true


local rgrav3 = Clone
	{
		scale = {1,1,0,0},
		source = rgrav2,
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "rgrav3",
		position = {1256,964,0},
		size = {64,49},
		opacity = 255,
		reactive = true,
	}

rgrav3.extra.focus = {}

function rgrav3:on_key_down(key)
	if rgrav3.focus[key] then
		if type(rgrav3.focus[key]) == "function" then
			rgrav3.focus[key]()
		elseif screen:find_child(rgrav3.focus[key]) then
			if rgrav3.on_focus_out then
				rgrav3.on_focus_out()
			end
			screen:find_child(rgrav3.focus[key]):grab_key_focus()
			if screen:find_child(rgrav3.focus[key]).on_focus_in then
				screen:find_child(rgrav3.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

rgrav3.extra.reactive = true


local hat = Image
	{
		src = "/assets/player_jump_hat.png",
		clip = {0,0,63,63},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "hat",
		position = {160,222,0},
		size = {63,63},
		opacity = 0,
		reactive = true,
	}

hat.extra.focus = {}

function hat:on_key_down(key)
	if hat.focus[key] then
		if type(hat.focus[key]) == "function" then
			hat.focus[key]()
		elseif screen:find_child(hat.focus[key]) then
			if hat.on_focus_out then
				hat.on_focus_out()
			end
			screen:find_child(hat.focus[key]):grab_key_focus()
			if screen:find_child(hat.focus[key]).on_focus_in then
				screen:find_child(hat.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

hat.extra.reactive = true


local jump = Image
	{
		src = "/assets/jump.png",
		clip = {0,0,188,124},
		scale = {0.5,0.5,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "jump",
		position = {262,292,0},
		size = {188,124},
		opacity = 255,
		reactive = true,
	}

jump.extra.focus = {}

function jump:on_key_down(key)
	if jump.focus[key] then
		if type(jump.focus[key]) == "function" then
			jump.focus[key]()
		elseif screen:find_child(jump.focus[key]) then
			if jump.on_focus_out then
				jump.on_focus_out()
			end
			screen:find_child(jump.focus[key]):grab_key_focus()
			if screen:find_child(jump.focus[key]).on_focus_in then
				screen:find_child(jump.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

jump.extra.reactive = true


local head3 = Image
	{
		src = "/assets/zon_head_9.png",
		clip = {0,0,1007,48},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "head3",
		position = {858,755,0},
		size = {1007,48},
		opacity = 0,
		reactive = true,
	}

head3.extra.focus = {}

function head3:on_key_down(key)
	if head3.focus[key] then
		if type(head3.focus[key]) == "function" then
			head3.focus[key]()
		elseif screen:find_child(head3.focus[key]) then
			if head3.on_focus_out then
				head3.on_focus_out()
			end
			screen:find_child(head3.focus[key]):grab_key_focus()
			if screen:find_child(head3.focus[key]).on_focus_in then
				screen:find_child(head3.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

head3.extra.reactive = true


local head2 = Image
	{
		src = "/assets/zon_head_8.png",
		clip = {0,0,925,48},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "head2",
		position = {876,755,0},
		size = {925,48},
		opacity = 0,
		reactive = true,
	}

head2.extra.focus = {}

function head2:on_key_down(key)
	if head2.focus[key] then
		if type(head2.focus[key]) == "function" then
			head2.focus[key]()
		elseif screen:find_child(head2.focus[key]) then
			if head2.on_focus_out then
				head2.on_focus_out()
			end
			screen:find_child(head2.focus[key]):grab_key_focus()
			if screen:find_child(head2.focus[key]).on_focus_in then
				screen:find_child(head2.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

head2.extra.reactive = true


local head1 = Image
	{
		src = "/assets/zon_head_7.png",
		clip = {0,0,855,48},
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "head1",
		position = {50,380,0},
		size = {855,48},
		opacity = 0,
		reactive = true,
	}

head1.extra.focus = {}

function head1:on_key_down(key)
	if head1.focus[key] then
		if type(head1.focus[key]) == "function" then
			head1.focus[key]()
		elseif screen:find_child(head1.focus[key]) then
			if head1.on_focus_out then
				head1.on_focus_out()
			end
			screen:find_child(head1.focus[key]):grab_key_focus()
			if screen:find_child(head1.focus[key]).on_focus_in then
				screen:find_child(head1.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

head1.extra.reactive = true

local deaths = Text
	{
		color = {0,0,0,255},
		font = "Soup of Justice 50px",
		text = "0",
		editable = false,
		wants_enter = true,
		wrap = true,
		wrap_mode = "CHAR",
		scale = {1,1,0,0},
		x_rotation = {0,0,0},
		y_rotation = {0,0,0},
		z_rotation = {0,0,0},
		anchor_point = {0,0},
		name = "deaths",
		position = {20,20,0},
		size = {150,64},
		opacity = 255,
		reactive = true,
		cursor_visible = false,
	}

deaths.extra.focus = {}

function deaths:on_key_down(key)
	if deaths.focus[key] then
		if type(deaths.focus[key]) == "function" then
			deaths.focus[key]()
		elseif screen:find_child(deaths.focus[key]) then
			if deaths.on_focus_out then
				deaths.on_focus_out()
			end
			screen:find_child(deaths.focus[key]):grab_key_focus()
			if screen:find_child(deaths.focus[key]).on_focus_in then
				screen:find_child(deaths.focus[key]).on_focus_in(key)
			end
			end
	end
	return true
end

deaths.extra.reactive = true

g:add(bg3,bg2,bg1,player,hat,image3,clone4,clone6,image7,clone8,clone9,clone21,clone22,clone23,grav1,grav2,clone15,clone16,clone17,
clone18,clone19,clone20,clone24,clone25,grav3,clone26,clone27,clone28,clone29,clone30,grav4,grav5,clone31,clone32,ggrav3,ggrav1,
ggrav2,rgrav1,rgrav2,rgrav3,jump,head3,head2,head1,deaths)


local colliders = {image7,clone8,clone9,clone21,clone22,clone23,grav1,grav2,clone15,clone16,clone17,
clone18,clone19,clone20,clone24,clone25,grav3,clone26,clone27,clone28,clone29,clone30,grav4,grav5,clone31,clone32,ggrav3,ggrav1,ggrav2,rgrav1,
rgrav2,rgrav3,jump}

grav1.extra.event = {event_type = "gravity up"}
grav2.extra.event = {event_type = "gravity up"}
grav3.extra.event = {event_type = "gravity down"}
grav4.extra.event = {event_type = "gravity up"}
grav5.extra.event = {event_type = "gravity up"}
ggrav1.extra.event = {event_type = "gravity down"}
ggrav2.extra.event = {event_type = "gravity down"}
ggrav3.extra.event = {event_type = "gravity down"}
rgrav1.extra.event = {event_type = "gravity up"}
rgrav2.extra.event = {event_type = "gravity up"}
rgrav3.extra.event = {event_type = "gravity up"}
jump.extra.event = {event_type = "jump upgrade"}

local event1 =
	{
		row = 2,
		time = 0,
		event_type = "appear",
		ui = head1,
		triggered = false,
	}

local event2 =
	{
		row = 3,
		time = 0,
		event_type = "appear",
		ui = head2,
		triggered = false,
	}

local event3 =
	{
		row = 3,
		time = 2350,
		event_type = "appear",
		ui = head3,
		triggered = false
	}

local event4 =
	{
		row = 3,
		time = 0,
		event_type = "disappear",
		ui = head1,
		triggered = false,
	}

local event5 =
	{
		row = 3,
		time = 1950,
		event_type = "disappear",
		ui = head2,
		triggered = false,
	}


local events = {event1,event2,event3,event4,event5}

return colliders, events
