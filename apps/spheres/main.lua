
--upvals to reduce the calls to get_w() & get_h()
screen_w = screen.w
screen_h = screen.h

--------------------------------------------------------------------------------
-- GLOBALS                                                                    --
--------------------------------------------------------------------------------

BULB_PAD                      = 24 -- alpha around a bulb in px
BULB_LINEAR_DAMPING           = 0.2
BULB_ANGULAR_DAMPING          = 0.02
BULB_FRICTION                 = 0.5
BULB_DENSITY                  = 1
BULB_BOUNCE                   = 1

BULB_FORCE                    = 30 * BULB_DENSITY -- how much force one key press exerts
BULB_OVERLAY_ROTATION_SPEED   = 20 -- degrees per second

SPHERE_PAD                    = 12 -- alpha around a spehere in px
SPHERE_LINEAR_DAMPING         = 0
SPHERE_ANGULAR_DAMPING        = 0.02
SPHERE_START_VELOCITY_MIN     = 6
SPHERE_START_VELOCITY_MAX     = 12
SPHERE_FRICTION               = 0.01
SPHERE_DENSITY                = 1
SPHERE_BOUNCE                 = 1

RING_ANIMATE_IN_DURATION      = 400

SCORE_FLIP_DURATION           = 200

SCORE_FONT                    = "DejaVu Sans Mono 50px"

--DEBUG                         = true

--------------------------------------------------------------------------------
-- COLORS for the players                                                     --
--------------------------------------------------------------------------------

RED           = "red"
GREEN         = "green"
BLUE          = "blue"
YELLOW        = "yellow"
NEUTRAL       = "N"

COLORS        = { RED , GREEN , BLUE , YELLOW }

local margin = 140

SPAWN_LOCATION = {
    [ RED    ]  = {            margin , screen_h - margin },
    [ GREEN  ]  = { screen_w - margin , screen_h - margin },
    [ YELLOW ]  = {            margin ,            margin },
    [ BLUE   ]  = { screen_w - margin ,            margin }
}

RING_START    =
{
    [ RED    ]  = {        0 , screen_h },
    [ GREEN  ]  = { screen_w , screen_h },
    [ YELLOW ]  = {        0 ,        0 },
    [ BLUE   ]  = { screen_w ,        0 }
}

--------------------------------------------------------------------------------
-- LAYERS                                                                     --
--------------------------------------------------------------------------------

clone_sources_layer = Group{     name = "Hidden Clone Sources"                 }

background_layer    = Group{     name = "Background"                           }

objects_layer       = Group{     name = "Arena Items / Obstacles layer"        }

player_balls_layer  = Group{     name = "Player Lair"                          }

hud_layer           = Group{     name = "HUD layer"                            }

menu_layer          = Group{     name = "Menu Layer"                           }



screen:add(
    
    clone_sources_layer,
    
    background_layer,
    
    objects_layer,
    
    player_balls_layer,
    
    hud_layer,
    
    menu_layer
    
)


clone_sources_layer:hide()



--------------------------------------------------------------------------------
-- STATE                                                                      --
--------------------------------------------------------------------------------

GAME_IS_LIVE = false



SCORE_ITEM_HANDLES = {}

PLAYER_HANDLES     = {}

--------------------------------------------------------------------------------
-- DOFILES                                                                    --
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Utility files

--The idle loop framework for appending animations to the physics engines idle loop
dofile("IdleLoop.lua")

--the State machine class
MAKE_ENUM = dofile("Enum.lua")

STATE = MAKE_ENUM{"OFFLINE","INTRO","SPLASH","GAME","ROUND_OVER","COUNTDOWN"}



--------------------------------------------------------------------------------
--Elements of the Arena/HUD

--the large 3-2-1 countdown timer that animates in between rounds
dofile("RoundCountdown.lua")
--the timer the countsdown the time limit for a round
dofile("MatchTimer.lua")
--Background Image and physics boards of the game Arena
dofile("SphereArena.lua")


--------------------------------------------------------------------------------
--Gameplay Objects

dofile("Formations.lua")      -- start formations of the collectable spheres
dofile("CollectableBall.lua") -- code for creating and launching the collectable spheres
dofile("Powerups.lua")        -- power ups that the player ball can collect

--Player UI elements
PLAYER_RINGS = dofile("PlayerRing.lua")  -- spawn location of the PLAYER_BALL
PLAYER_SCORE = dofile("PlayerScore.lua") -- score counter, child of PLAYER_RING
PLAYER_BALLS = dofile("PlayerBall.lua")

-- links the Player UI elements and the User's Controller
dofile("Player.lua") 


-- setups up the controller events, connecting the players to their balls
dofile("IPhoneController.lua")


--------------------------------------------------------------------------------
-- Menus

--The splash screen & intro animation
dofile("SplashScreen.lua")

--------------------------------------------------------------------------------
-- Start the game                                                             --
--------------------------------------------------------------------------------

physics.gravity = { 0 , 0 }

physics:start()

screen:show()

-- if i don't delay the start of the app you seem to miss the intro animation
dolater(
    
    2000,
    
    function()
        
        STATE:change_state_to("INTRO")
        
    end
)

--collect all of the temporary upvals and tables generated in all of the
--initialization code
collectgarbage("collect")




