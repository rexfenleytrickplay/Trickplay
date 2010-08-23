SMALL_BLIND = 1
BIG_BLIND = 2
INITIAL_ENDOWMENT = 200

HELP_ENABLED = true

ASSERTIONS_ENABLED = true

if ASSERTIONS_ENABLED then
   local old_assert = assert
   function assert(...)
      if cond then
         if msg then print(msg)
         else print("assertion failed...") end
      end
   end
end

Directions = {
   RIGHT = {1,0},
   LEFT = {-1,0},
   DOWN = {0,1},
   UP = {0,-1}
}

Colors={
   SLATE_GRAY                   ="708090",
   WHITE                        ="FFFFFF",
   FIRE_BRICK                   ="B22222",
   LIME_GREEN                   ="32CD32",
   TURQUOISE                    ="40E0D0",
   BLACK                        ="000000",
   RED                          ="FF0000",
   YELLOW                       ="FFFF00",
   GREEN                        ="00FF00",
   BLUE                         ="0000FF",
   MAGENTA                      ="FF00FF",
   CYAN                         ="00FFFF",
   ORANGE                       ="FFA500",
   PURPLE                       ="A020F0",
   PERU                         ="CD853F",
   FOCUS_RED                    ="602020"
}

PLAYER_NAME_FONT = "KacstArt 20px"
PLAYER_ACTION_FONT = "KacstArt 40px"

CUSTOMIZE_TINY_FONT = "KacstArt 24px"
CUSTOMIZE_TINIER_FONT = "KacstArt 20px"
CUSTOMIZE_TAB_FONT  = "KacstArt 48px"
CUSTOMIZE_ENTRY_FONT = "KacstArt 28px"
CUSTOMIZE_SUB_FONT  = "KacstArt 32px"
CUSTOMIZE_SUB_FONT_B  = "KacstArt 36px"
CUSTOMIZE_SUB_FONT_SP  = "KacstArt 42px"
CUSTOMIZE_NAME_FONT = "KacstArt 144px"

DEFAULT_FONT = "DejaVu Serif 40px"
DEFAULT_COLOR = Colors.WHITE

Rounds = {
   HOLE=1,
   FLOP=2,
   TURN=3,
   RIVER=4,
}

Position = {
    EARLY = 1,
    EARLY2 = 2,     --Same as Early but redundancy for 6 players
    MIDDLE = 3,
    LATE = 4,
    SMALL_BLIND = 5,
    BIG_BLIND = 6
}
RaiseFactor = {
    UR = 1,     --Un-Raised Big-Blind
    R = 2,      --Raised Big-Blind
    RR = 3      --Re-Raised Big-Blind
}
Moves = {
    CALL = 1,
    RAISE = 2,
    FOLD = 3
}
SUITED = 1
UNSUITED = 2

HIGH_OUTS_RANGE = .66
LOW_OUTS_RANGE = .33

--adjusts standard deviation in decision making
Difficulty = {
    HARD = 1,
    MEDIUM = 2,
    EASY = 3
}

CHANGE_VIEW_TIME = 400

-- SOUNDS

DEAL_WAV = "assets/sounds/sound84.wav"
SHOWDOWN_WAV = "assets/sounds/Dog Bark 3.wav"
SHUFFLE_WAV = "assets/sounds/Shuffle 1.wav"
--FOLD_WAV = "assets/sounds/Dog bust out 4.wav"
FOLD_WAV = "assets/sounds/sound57.wav"
CHECK_WAV = "assets/sounds/check.wav"
CALL_WAV = "assets/sounds/Chips.wav"
RAISE_WAV = "assets/sounds/Chips.wav"
BUSTOUT_WAV = "assets/sounds/Bust out sound.wav"

local MYTURN_STRINGS = {"My turn!", "I'm up", "On me", "Hmmm", "Woof woof", "Me me me"}
function GET_MYTURN_STRING()
   return MYTURN_STRINGS[math.random(#MYTURN_STRINGS)]
end