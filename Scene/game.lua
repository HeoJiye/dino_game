-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

-- customModule
local dinoModule = require( "customModule.dino" )
local dino = dinoModule.New();

function scene:create( event )
	local sceneGroup = self.view

	-- 1차시: display 배치로 워밍업 + widget button 사용해보기

	-- 1. BG
		local bgGroup = display.newGroup();
		local background = display.newRect(bgGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )

		local sky = display.newImageRect(bgGroup, "Content/Sky.png", display.contentWidth, display.contentHeight)
		sky.x, sky.y = display.contentWidth/2, display.contentHeight/2

		local ground = display.newImageRect(bgGroup, "Content/Ground.png", display.contentWidth, 300)
		ground.x, ground.y = display.contentWidth/2, display.contentHeight-150

		sceneGroup:insert(bgGroup)

	-- 2. UI
		local UIGroup = display.newGroup();
		local playUI = {}
		playUI[0] = display.newImageRect(UIGroup, "Content/play.png", 55, 55)
		playUI[0].x, playUI[0].y = 1180, 40
		playUI[0].alpha = 0
		playUI[1] = display.newImageRect(UIGroup, "Content/stop.png", 55, 55)
		playUI[1].x, playUI[1].y = 1180, 40

		local bgmUI = {}
		bgmUI[0] = display.newImageRect(UIGroup, "Content/on.png", 55, 55)
		bgmUI[0].x, bgmUI[0].y = 1240, 40
		bgmUI[0].alpha = 1
		bgmUI[1] = display.newImageRect(UIGroup, "Content/off.png", 55, 55)
		bgmUI[1].x, bgmUI[1].y = 1240, 40
		bgmUI[1].alpha = 0

		



		sceneGroup:insert(UIGroup)

	-- 2차시: sound 사용하기 (+ 모듈 사용 기초) // 미완성
		-- local soundOn = 1
		-- local bgmUI = {}
		-- bgmUI[0] = display.newImageRect("Content/on.png", 55, 55)
		-- bgmUI[0].x, bgmUI[0].y = 1240, 40
		-- bgmUI[0].alpha = 1
		-- bgmUI[1] = display.newImageRect("Content/off.png", 55, 55)
		-- bgmUI[1].x, bgmUI[1].y = 1240, 40
		-- bgmUI[1].alpha = 0

		-- -- Sound Effect
		-- local se = {}
		-- se.jump = audio.loadSound( "Content/Audio/jump.mp3" )
		-- se.down  = audio.loadSound( "Content/Audio/down.mp3" ) 
		-- se.collide = audio.loadSound( "Content/Audio/defeat.mp3" )
		-- se.button = audio.loadSound( "Content/Audio/button.mp3" ) 

		-- -- BGM
		-- local function soundToggle( ... )
		-- 	if soundOn == 1 then
		-- 		soundOn = 0
		-- 		bgmUI[0].alpha = 0
		-- 		bgmUI[1].alpha = 1
		-- 		audio.pause( bgmPlayer )
		-- 	else
		-- 		soundOn = 1
		-- 		bgmUI[0].alpha = 1
		-- 		bgmUI[1].alpha = 0
		-- 		audio.resume( bgmPlayer )
		-- 	end
		-- end
		-- bgmUI[0]:addEventListener("tap", soundToggle)
		-- bgmUI[1]:addEventListener("tap", soundToggle)

		-- -- PLAY
		-- local function gameResume( )
		-- 	audio.play( se.button )
		-- 	playUI[0].alpha = 0
		-- 	playUI[1].alpha = 1

		-- 	for i = 0, #UI do
		-- 		UI[i].alpha = 0
		-- 	end

		-- 	timer.resume( scoreEvent )
		-- 	dino:setSequence( "run" )
		--     dino:play()

		--     physics.start()
		--     timer.resume( spawnTimer )
		--     timer.resume( resetTimer )

		--     Runtime:addEventListener( "key", onKeyJumpEvent )
		-- 	Runtime:addEventListener( "key", onKeyDownEvent )
		-- 	print("resume")
		-- end

		-- local function gamePause()
		-- 	audio.play( se.button )
		-- 	playUI[0].alpha = 1
		-- 	playUI[1].alpha = 0

		-- 	for i = 0, #UI do
		-- 		UI[i].alpha = 1
		-- 	end

		--    	timer.pause( scoreEvent )			
		-- 	dino:setSequence( "idle" )
		--     dino:pause()

		--     physics.pause()
		--     transition.cancelAll()
		--     dino.y = display.contentHeight/2

		--     timer.pause( spawnTimer )
		--     timer.pause( resetTimer )

		--  	Runtime:removeEventListener( "key", onKeyJumpEvent )
		-- 	Runtime:removeEventListener( "key", onKeyDownEvent )
		-- 	print("pause")
		-- end

		-- playUI[0]:addEventListener("tap", gameResume)
		-- playUI[1]:addEventListener("tap", gamePause)
		-- UI[1]:addEventListener("tap", gameResume)
		-- UI[2]:addEventListener("tap", gameResume) 

	-- 3차시: dino 넣기 

	local sildeButton = widget.newButton(
			{
				shape ="circle", radius = 75,
				fillColor = { default={ 1, 0.2, 0.5, 1 }, over={ 1, 0.2, 0.5, 0.7 } },
				x = 200, y = 600,
				onPress = function()
					dino:sildeStart()
				end,
				onRelease = function()
					dino:sildeEnd()
				end
			}
		)
	local jumpButton = widget.newButton(
		{
			shape ="circle", radius = 75,
			fillColor = { default={ 1, 0.2, 0.5, 1 }, over={ 1, 0.2, 0.5, 0.7 } },
			x = 1100, y = 600,
			onRelease = function()
				dino:jump()
			end
		}
	)

	dino:init(display.contentWidth*0.2, display.contentHeight*0.5)

	UIGroup:insert(sildeButton)
	UIGroup:insert(jumpButton)
	
	-- 4차시: 장애물 넣기 // 미완성
		-- local obstacleGroup = display.newGroup();
	 --    local obstacle = {}
		-- obstacle[1] = display.newImageRect(obstacleGroup, "Content/bone1.png", 69, 95)
		-- obstacle[2] = display.newImageRect(obstacleGroup, "Content/bone2.png", 131, 115)
		-- obstacle[3] = display.newImageRect(obstacleGroup, "Content/bone3.png", 117, 84)
		-- obstacle[4] = display.newImageRect(obstacleGroup, "Content/Ptero.png", 276, 119)

		-- local obstacleOutline = {}
		-- obstacleOutline[1] = graphics.newOutline(2, "Content/bone1.png")
		-- obstacleOutline[2] = graphics.newOutline(2, "Content/bone2.png")
		-- obstacleOutline[3] = graphics.newOutline(2, "Content/bone3.png")
		-- obstacleOutline[4] = graphics.newOutline(2, "Content/Ptero.png")

		-- for i = 1, 3, 1 do 
		-- 	obstacle[i].x, obstacle[i].y = display.contentWidth+200, display.contentHeight-280
		-- end
		-- obstacle[4].x, obstacle[4].y = display.contentWidth+200, 200

		-- local cooltime
		-- local obs_idx

		-- function createObstacle()
		-- 	cooltime = math.random(1, 4)-- 0.5~2초 사이의 간격으로 스폰
		-- 	obs_idx = math.random(1, 4)	-- 1~5번 장애물 중 랜덤선택
		-- 	print("spawn time = "..cooltime)
		-- 	print("obstacle idx is "..obs_idx)
		-- 	spawnTimer = timer.performWithDelay(cooltime*500, spawnObstacle)
		-- end

		-- function deleteObstacle()			-- 다시 화면 밖으로(초기상태로)
		-- 	print("obstacle.x is out of screen")
		-- 	obstacle[obs_idx]:setLinearVelocity( 0, 0 )
		-- 	physics.removeBody(obstacle[obs_idx])
		-- 	obstacle[obs_idx].x = display.contentWidth+200
		-- 	createObstacle()
		-- end

		-- function spawnObstacle()
		-- 	print("spawn obstacle")
		-- 	physics.addBody( obstacle[obs_idx], "dynamic", { friction=0, outline=obstacleOutline[obs_idx] })
		-- 	obstacle[obs_idx]:setLinearVelocity( -500, 0 )	-- 장애물 이동
		-- 	resetTimer = timer.performWithDelay(4000, deleteObstacle)
		-- end

		-- -- 충돌 구현 
		-- local function onCollision( event ) 
		--     if ( event.phase == "began" ) then
		--     	audio.play( se.collide )
		--         dino:setSequence( "collide" )
		--  		print("collide")

		--  		Runtime:removeEventListener( "key", onKeyJumpEvent )
		-- 		Runtime:removeEventListener( "key", onKeyDownEvent )
		-- 		Runtime:removeEventListener( "collision", onCollision )
		 		
		--  		composer.setVariable( "score", score )
		-- 		composer.gotoScene( "end", { time=800, effect="crossFade" } )
		--     end
		-- end

	-- 5차시: physic와 점수 추가
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then

	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then

	elseif phase == "did" then

	end
end

function scene:destroy( event )
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
