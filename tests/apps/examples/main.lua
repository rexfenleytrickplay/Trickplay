
local contents = app.contents

local H = 46
local COLS = 3
local top = 10
local left = 10

local tests = {}
local tests_per_column = 0

local last_run = settings.last

local focused = nil

local files = {}

for i = 1 , #contents do
    local file = contents[ i ]
    local name = string.match( file , "examples/(.*)%.lua" )
    if name then
        table.insert( files , file )
    end
end

table.sort( files )

for i = 1 , #files do
    local file = files[ i ]
    local name = string.match( file , "examples/(.*)%.lua" )
    if name then
        name = string.gsub( name , "_" , " " )
        local text = Text
        {
            font = "FreeSans "..tostring( H - 14 ).."px",
            color = "FFFFFF",
            text = name,
            x = left,
            y = top,
            extra = { file = file }
        }
        
        screen:add( text )
        
        table.insert( tests , text )
        
        top = top + H
        if top + H > screen.h then
            tests_per_column = #tests-1
            --print("tests_per_column",tests_per_column)
            top = 10
            left = left + screen.w / COLS
        end
        
        if last_run == file then
            focused = # tests
        end
        
    end
end
    
if # tests > 0 then

    focused = focused or 1
    
    local focus = Rectangle
    {
        color = "964e20" ,
        size = { screen.w / COLS , H } ,
        position = tests[ focused ].position 
    }
    
    screen:add( focus )
    
    focus:lower_to_bottom()
        
    function screen.on_key_down( screen , key )
        
        if key == keys.Up and focused > 1 then
            focused = focused - 1
            focus.position = tests[ focused ].position
        elseif key == keys.Down and focused < # tests then
            focused = focused + 1
            focus.position = tests[ focused ].position
        elseif key == keys.Left and focused > tests_per_column then
            focused = focused - (tests_per_column+1)
            focus.position = tests[ focused ].position
        elseif key == keys.Right and focused < #tests-tests_per_column then
            focused = focused + (tests_per_column+1)
            focus.position = tests[ focused ].position
        elseif key == keys.Return then
            local file = tests[ focused ].extra.file
            settings.last = file
            screen:clear()
            screen.on_key_down = nil
            dofile( file )
        end
        
    end
    
end
    
screen:show()
