## 장애물

장애물도 코드를 모듈로 분리할 건데, 4가지의 장애물을 displayGroup으로 묶어서 module화 할게요~

1. obstacleModule 생성
    ```lua
    local obstacleModule = {}

    function obstacleModule.New()
        local obstacleGroup = display.newGroup();

        local obstacle = {}
        obstacle[1] = display.newImage(obstacleGroup, "Content/bone1.png")
        obstacle[2] = display.newImage(obstacleGroup, "Content/bone2.png")
        obstacle[3] = display.newImage(obstacleGroup, "Content/bone3.png")
        obstacle[4] = display.newImage(obstacleGroup, "Content/Ptero.png")

        for i = 1, 3, 1 do 
            obstacle[i].x, obstacle[i].y = 200 + (200*i), display.contentHeight-280
        end
        obstacle[4].x, obstacle[4].y = display.contentCenterX, 200

        return obstacleGroup;
    end

    return obstacleModule;
    ```

    ```lua
    local obstacleModule = require( "module.obstacleModule" )
    ```
    ```lua
    local obstacles = obstacleModule.New()
	sceneGroup:insert(obstacles)
    ```

2. Physics 추가
    ```lua
    local obstacleOutline = {}
	obstacleOutline[1] = graphics.newOutline(2, "Content/bone1.png")
	obstacleOutline[2] = graphics.newOutline(2, "Content/bone2.png")
	obstacleOutline[3] = graphics.newOutline(2, "Content/bone3.png")
	obstacleOutline[4] = graphics.newOutline(2, "Content/Ptero.png")

    for i = 1, 4, 1 do
        physics.addBody(obstacle[i], { outline = obstacleOutline[i] })
    end
    ```

3. obstacle 생성
    화면 밖으로 세팅
    ```lua
    for i = 1, 3, 1 do 
    	obstacle[i].x, obstacle[i].y = display.contentWidth+200, display.contentHeight-280
    end
    obstacle[4].x, obstacle[4].y = display.contentWidth+200, 200
    ```

    ```lua
    local cooltime
	local obs_idx
    
    function obstacleGroup:start()
        cooltime = math.random(200, 1000)
		obs_idx = math.random(1, 4)

		spawnTimer = timer.performWithDelay(cooltime, 
            function() 
                physics.addBody( obstacle[obs_idx], "kinematic", { friction=0, outline = obstacleOutline[obs_idx] })
                obstacle[obs_idx]:setLinearVelocity( -500, 0)

                resetTimer = timer.performWithDelay(3000, 
                    function()
                        obstacle[obs_idx]:setLinearVelocity( 0, 0 )
                        physics.removeBody(obstacle[obs_idx])
                        obstacle[obs_idx].x = display.contentWidth+200

                        obstacleGroup:start()
                    end)
            end)
    end
    ```
