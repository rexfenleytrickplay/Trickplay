
local function rc()
    local result = {}
    for i = 1 , 3 do
        table.insert( result , math.random( 255 ) )
    end
    return result
end

body = nil

for i = 1 , 30 do
    
    local h = math.random( 50 , 100 )
    
    local r = Rectangle
    {
        color = rc() ,
        w = math.random( 50 , 100 ),
        h = h,
        x = math.random( screen.w ) ,
        y = -h
    }
    
    local b = 
    physics:Body
        {
            source = r,
            density = 1.0 ,
            friction = 0.5 ,
            bounce = 0.5,
            dynamic = true
        }
        
    if not body then
        body = b
        r.border_width = 4
        r.border_color = "FFFFFF"
    end
    
    screen:add( r )

end


g = Rectangle
{
    color = "00FF0066" ,
    size = { screen.w , 100 } ,
    position = { screen.w / 2 , screen.h - 150 } ,
    anchor_point = { screen.w / 2 , 50 },
    z_rotation = { 10 , 0 , 0  }
}

screen:add( g )



ground = physics:Body{ source = g , friction = 0.2 }

g = Rectangle
{
    color = "00FF0066",
    size = { screen.w / 2 , 50 },
    position = { 1200 , screen.h / 3 },
    anchor_point = { screen.w / 4 , 25 },
    z_rotation = { -30 , 0 , 0  }
}

screen:add( g )

slide = physics:Body{ source = g , friction = 0.8 }

-------------------------------------------------------------------------------
-- Add invisible bumpers on the left, right and bottom of the screen

g = Group{ size = { 2 , screen.h } , position = { -2 , 0 } }
screen:add( g )
physics:Body{ source = g }

g = Group{ size = { 2 , screen.h } , position = { screen.w , 0 } }
screen:add( g )
physics:Body{ source = g }

g = Group{ size = { screen.w , 2 } , position = { 0 , screen.h } }
screen:add( g )
physics:Body{ source = g }

-------------------------------------------------------------------------------


screen:show()

physics.gravity = { 0 , 10 }


if false then

    local ret = keys.Return
    
    function screen.on_key_down( screen , key )
        if key == ret then
            physics:step()
            
            print(
            
                body.position[1] ,
                body.position[2] ,
                body.angle ,
                body.linear_velocity[1] ,
                body.linear_velocity[2],
                body.angular_velocity
            )
            
        end
    end

else

    local s = Stopwatch()
    local f = 1 / 60;
    local n
    
    function idle.on_idle()
        if s.elapsed_seconds >= f then
            n = physics:step()
            --print( n )
            s:start()
        end
    end
    
    local up = keys.Up
    local down = keys.Down
    local left = keys.Left
    local right = keys.Right
    local space = keys.space
    
    function screen.on_key_down( screen , key )
        local p = body.position
        local vx , vy = unpack( body.linear_velocity )
        if key == up and vy > -2 then
            body:apply_linear_impulse( 0 , -8 , p[ 1 ] , p[ 2 ] )
        elseif key == down then
            body:apply_force( 0 , 600 , p[ 1 ] , p[ 2 ] )
        elseif key == left then
            body:apply_force( -600 , 0 , p[ 1 ] , p[ 2 ] )
        elseif key == right then
            body:apply_force( 600 , 0 , p[ 1 ] , p[ 2 ] )
        elseif key == space then
            body:apply_torque( -100 )
        end
    end
end
