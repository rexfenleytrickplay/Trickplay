mediaplayer:pause()

local SHADOW_COLOR = "000000"
local SHADOW_OPACITY = 255 * 1/4

-- Return a group with the text and a shadow version of the text
local ShadowText = function(properties, offset)
	local maintext = Text (properties)
	local shadow = Text {
							font = maintext.font,
							text = maintext.text,
							wrap = maintext.wrap,
							x = maintext.x + offset.x,
							y = maintext.y + offset.y,
							z = maintext.z-1,
							w = maintext.w,
							color = SHADOW_COLOR,
							opacity = SHADOW_OPACITY
						}
	return Group { children = { shadow, maintext } }
end


local curtain = Rectangle { x=-100, y=-100, w = screen.w*2, h = screen.h*2, z = -10, color = "000000", opacity = 255 }
local media = Group {}

screen:add(media,curtain)

local assets = {
	credits = {
		Image { src = "assets/credits/background-image-credits.png",		x = 0,		y = 0 },
		Image { src = "assets/credits/trueblood-credits-background.png",	x = 1254,	y = 0 },
		Group { children = {
					ShadowText({ font = "Fontin Small Caps 58px", color = "ffffff", text = "Get Exclusive", x = 0, y = 0 },	{ x=3, y=3 }),
					ShadowText({ font = "Fontin Small Caps 58px", color = "AD2329", text = "True Blood", x = 0, y = 54 },	{ x=3, y=3 }),
					ShadowText({ font = "Fontin Small Caps 58px", color = "ffffff", text = "Merchandise", x = 0, y = 108 },	{ x=3, y=3, }),
				},
				w = 397,											x = 1480, y = 39  },
		Image { src = "assets/credits/button-shopnow.png",			x = 1480, y = 223 },
		Image { src = "assets/credits/product-shirt-medium.png",	x = 1480, y = 297 },
		Image { src = "assets/credits/product-drink-medium.png",	x = 1480, y = 707 },
	},

	drink = {
		Image { src = "assets/shop-drink/background-image-drinks.jpg",		x = 0,		y = 0 },

		Image { src = "assets/shop-common/trueblood-shop-bkgd.png",			x = 0,		y = 0 },
		Image { src = "assets/shop-common/merch-shirt-red.png",				x = 30,		y = 800 },
		Image { src = "assets/shop-common/merch-drink.png",					x = 510,	y = 800 },
		Image { src = "assets/shop-common/merch-dvd.png",					x = 990,	y = 800 },
		Image { src = "assets/shop-common/merch-shirt-black.png",			x = 1470,	y = 800 },
		Image { src = "assets/shop-common/quantity-1.png",					x = 1442,	y = 660 },
		Image { src = "assets/shop-common/button-addtocart.png",			x = 1442,	y = 741 },

		Image { src = "assets/shop-drink/product-drink-large.png",			x = 662,	y = 29 },
		Group { children = {
					ShadowText({ font = "Fontin Small Caps 58px", color = "ffffff", wrap=true, text = "Tru Blood Beverage - 4 Pack", w=470, x = 0, y = 0},	{ x=3, y=3}),
					ShadowText({ font = "Fontin 36px", color = "ffffff", wrap=true, text = "Sink your fangs into a bottle of Tru Blood, a delicious blood orange carbonated drink inspired by Bill's favorite synthetic blood nourishment beverage. Stunning bottle design is an exact replica of bottles featured on the show.", w=470, x=0, y=140}, { x=3, y=3}),
					ShadowText({ font = "Fontin 58px", color = "ffffff", text = "$17.95", x = 0, y=550},	{x=3, y=3})
				},
				w=477,														x = 1442,	y = 29 },
	},
	
	shirt = {
		Image { src = "assets/shop-shirt/background-image-shirt.jpg",		x = 0,		y = 0 },

		Image { src = "assets/shop-common/trueblood-shop-bkgd.png",			x = 0,		y = 0 },
		Image { src = "assets/shop-common/merch-shirt-red.png",				x = 30,		y = 800 },
		Image { src = "assets/shop-common/merch-drink.png",					x = 510,	y = 800 },
		Image { src = "assets/shop-common/merch-dvd.png",					x = 990,	y = 800 },
		Image { src = "assets/shop-common/merch-shirt-black.png",			x = 1470,	y = 800 },
		Image { src = "assets/shop-common/quantity-1.png",					x = 1442,	y = 660 },
		Image { src = "assets/shop-common/button-addtocart.png",			x = 1442,	y = 741 },

		Image { src = "assets/shop-shirt/product-shirt-large.png",			x = 662,	y = 29 },
		Group { children = {
					ShadowText({ font = "Fontin Small Caps 62px", color = "ffffff", wrap=true, text = "Fangtasia Women's Fitted T-Shirt – Red", w=470, x = 0, y = 0},	{ x=3, y=3}),
					ShadowText({ font = "Fontin 36px", color = "ffffff", wrap=true, text = "The Fangtasia - Life Begins at Night logo is boldly printed on the front. The 'address' is printed on the back of the shirt. This soft and comfortable t-shirt is made of 100% cotton.", w=470, x=0, y=220}, { x=3, y=3}),
					ShadowText({ font = "Fontin 58px", color = "ffffff", text = "$27.95", x = 150, y=542},	{x=3, y=3})
				},
				w=477,														x = 1442,	y = 29 },
		Image { src = "assets/shop-shirt/button-size-small.png",			x = 1402,	y = 579 },
	},
}

for _,child in pairs(assets.credits[3].children) do
	child.x = (assets.credits[3].w - child.w) / 2
end

assets.drink[10].children[3].x = (assets.drink[10].w - assets.drink[10].children[3].w)/2
assets.shirt[10].children[3].x = (assets.shirt[10].w - assets.shirt[10].children[3].w)/2

local states = { assets.credits, assets.drink, assets.shirt, current=1 }

media:add(unpack(states[states.current]))
screen:show()

function screen.on_key_down ( screen, key )
	if key == keys.Right or key == keys.Return or key == keys.Down then
		states.current = math.min(states.current + 1, #states)
	elseif key == keys.Left or key == keys.Up then
		states.current = math.max(states.current - 1, 1)
	else return
	end
	media:animate({duration = 250, opacity = 0, y = screen.h, mode = "EASE_OUT_SINE", on_completed = function()
		media:clear()
		media:add(unpack(states[states.current]))
		media:animate({duration = 250, mode = "EASE_IN_SINE", opacity = 255, y = 0 })
	end})
end
