
local module = {}

function module.New()
	local dino = {
		imgSheet = graphics.newImageSheet( "Content/Playerd.png", { width = 214, height = 217, numFrames = 6 }),
		sepuencesData =
		{
			{ name = "idle",	start = 1, count = 1 },
			{ name = "run",  	start = 1, count = 3, time = 400 },
			{ name = "jump", 	start = 4, count = 1 },
			{ name = "silde", 	start = 5, count = 1 },
			{ name = "collide", start = 6, count = 1 }
		},
		isJump = false
	}
	dino.dinoOutline = {
			idle = graphics.newOutline(2, dino.imgSheet, 1),
			silde = graphics.newOutline(2, dino.imgSheet, 5)
		}
	dino.dinoSprite = display.newSprite( dino.imgSheet, dino.sepuencesData )

	dino.dinoSprite.x, dino.dinoSprite.y = -1000, -1000

	function dino:init( x, y )
		dino.dinoSprite.x, dino.dinoSprite.y = x, y

		dino.dinoSprite:setSequence( "run" )
		dino.dinoSprite:play()

		dino.isJump = false
	end

	function dino:anim( state )
		dino.dinoSprite:setSequence( state )
		dino.dinoSprite:play()
	end

	function dino:jump()
	 	if (dino.dinoSprite.y == display.contentHeight/2) then
	 		dino.isJump = 1
	 		transition.to( dino.dinoSprite, { time=300,  y=(dino.dinoSprite.y-200), 
	 			onComplete = function() 
		 			transition.to( dino.dinoSprite, { time=1500,  y=(dino.dinoSprite.y+200), onComplete = function() dino:anim( "run" ) end } )
    				dino.isJump = false
		 		end } )
	 		
	 		dino:anim( "jump" )
	 		dino.isJump = true
	    end
	end

	function dino:sildeStart()
		if (dino.isJump == false) then
			print(sg)
	 		transition.pause( dino.dinoSprite )
	 		dino:anim( "silde" )

	 		dino.dinoSprite.y = display.contentHeight/2

	 		physics.removeBody( dino.dinoSprite )
	 		physics.addBody(dino.dinoSprite, "static", { friction=0, outline = dino.dinoOutline.silde }) 
	 	end
	end

	function dino:sildeEnd( event )
		if (dino.isJump == false) then
			dino:anim( "run" )

	 		physics.removeBody( dino.dinoSprite )
		 	physics.addBody(dino.dinoSprite, "static", { friction=0, outline = dino.dinoOutline.idle }) 
	 	end
	end

	return dino
end

return module