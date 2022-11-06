## 공룡 게임 마무리

1. score 넣기
    ```lua
    local score = 0
	local scoreUI = display.newText(score, display.contentWidth*0.25, display.contentHeight*0.15, 500, 100)
	scoreUI.align = "right"
	scoreUI:setFillColor(0)
	scoreUI.size = 80

	local function scoreUp( event )
		score = score + 1
		scoreUI.text = score
	end
	local scoreUpTimer = timer.performWithDelay( 250, scoreUp, 0 )
    ```

2. score end Scene에 전달
    ```lua
    local function onCollision( event ) 
	    if ( event.phase == "began" ) then
	        dino:animation('collide')
			Runtime:removeEventListener( "collision", onCollision )

			composer.setVariable("score", score)
			composer.gotoScene( "Scene.end", { time=800, effect="crossFade" } )
	    end
	end
	Runtime:addEventListener( "collision", onCollision )
    ```

3. game pause/resume
    ```lua
    local function playPause( event )
		playUI[0].alpha = 0
		playUI[1].alpha = 1

		physics.pause()
		timer.pauseAll()
	end
	local function playResume( event )
		playUI[0].alpha = 1
		playUI[1].alpha = 0

		physics.resume()
		timer.resumeAll()
	end
	playUI[0]:addEventListener("tap", playPause)
	playUI[1]:addEventListener("tap", playResume)
    ```
    
4. 효과음 넣기