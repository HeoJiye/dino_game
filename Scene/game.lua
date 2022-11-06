-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- STEP 01. Scene.game BG & UI

	-- 2. BG
	local bgGroup = display.newGroup();
	local background = display.newRect(bgGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	
	local sky = display.newImageRect(bgGroup, "Content/Sky.png", display.contentWidth, display.contentHeight)
	sky.x, sky.y = display.contentCenterX, display.contentCenterY
	
	local ground = display.newImageRect(bgGroup, "Content/Ground.png", display.contentWidth, 300)
	ground.x, ground.y = display.contentCenterX, display.contentHeight-150

	sceneGroup:insert(bgGroup)

	-- 3. UI
	local UIGroup = display.newGroup();

	local playUI = {}
	playUI[0] = display.newImageRect(UIGroup, "Content/stop.png", 55, 55)
	playUI[0].x, playUI[0].y = 1180, 40
	playUI[0].alpha = 1
	playUI[1] = display.newImageRect(UIGroup, "Content/play.png", 55, 55)
	playUI[1].x, playUI[1].y = 1180, 40
	playUI[1].alpha = 0

	local bgmUI = {}
	bgmUI[0] = display.newImageRect(UIGroup, "Content/on.png", 55, 55)
	bgmUI[0].x, bgmUI[0].y = 1240, 40
	bgmUI[0].alpha = 1
	bgmUI[1] = display.newImageRect(UIGroup, "Content/off.png", 55, 55)
	bgmUI[1].x, bgmUI[1].y = 1240, 40
	bgmUI[1].alpha = 0

	sceneGroup:insert(UIGroup)

	-- 3-1 UI event
	local function playPause( event )
		playUI[0].alpha = 0
		playUI[1].alpha = 1
		print("bgmPause")
	end
	local function playResume( event )
		playUI[0].alpha = 1
		playUI[1].alpha = 0
		print("bgmResume")
	end
	playUI[0]:addEventListener("tap", playPause)
	playUI[1]:addEventListener("tap", playResume)

	local function bgmPause( event )
		bgmUI[0].alpha = 0
		bgmUI[1].alpha = 1
		print("bgmPause")
	end
	local function bgmResume( event )
		bgmUI[0].alpha = 1
		bgmUI[1].alpha = 0
		print("bgmResume")
	end
	bgmUI[0]:addEventListener("tap", bgmPause)
	bgmUI[1]:addEventListener("tap", bgmResume)


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
