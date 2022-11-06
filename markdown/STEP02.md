## STEP2. andioManager (module 사용 기초)

사운드를 넣어볼 껀데, 사운드는 모든 씬에 통틀어서 사용하게 됨. 그래서 외부 모듈에 따로 구현해보겠다

1. 외부 모듈 작성하기 (module/audioManager.lua)
    ```lua
    -- STEP 02. audioManager module

    local audioManager = { }

    local audioData = {
        bgm = audio.loadStream("Content/Audio/bgm.mp3"),
        sounds = {
            audio.loadSound("Content/Audio/01_botton.mp3"),
            audio.loadSound("Content/Audio/02_defeat.mp3"),
            audio.loadSound("Content/Audio/03_down.mp3"),
            audio.loadSound("Content/Audio/04_jump.mp3"),
        },
        bgmChannel = 1,
        soundChannel = 2
    }

    function audioManager:bgm( command )
        if(command == 'play') then
            audio.play(audioData.bgm, {
                channel = bgmChannel,
                loops = -1
            })
        elseif(command == 'pause') then
            audio.pause(audioData.bgm)
        elseif(command == 'resume') then
            audio.resume(bgmChannel)
        elseif(command == 'stop') then
            audio.resume(bgmChannel)
        end
    end 

    function audioManager:sound( idx, command )
        if(command == 'play') then
            audio.play(audioData.sounds[idx], {
                channel = soundChannel
            })
        elseif(command == 'pause') then
            audio.pause(audioData.sounds[idx])
        elseif(command == 'resume') then
            audio.resume(soundChannel)
        elseif(command == 'stop') then
            audio.stop(soundChannel)
        end
    end
    function audioManager:sound( command )
        if(command == 'resume') then
            audio.resume(soundChannel)
        elseif(command == 'stop') then
            audio.stop(soundChannel)
        end
    end

    -- Expansion. setVolume()

    -- function audioManager:bgmVolume( volume )
    --     audio.setVolume(volume, {channel = bgmChannel})
    -- end
    -- function audioManager:soundVolume( volume )
    --     audio.setVolume(volume, {channel = soundChannel})
    -- end

    return audioManager
    ```

2. 배경음악 적용하기 (Scene.start)
    ```lua
    local audioManager = require( "module.audioManager" )
    ```
    ```lua
    audioManager:bgm("play")
    ```

3. 배경음악 이벤트 적용하기 (Scene.game)
    ```lua
    local audioManager = require( "module.audioManager" )
    ```
    ```lua
    audioManager:bgm("pause")
    ```
    ```lua
    audioManager:bgm("resume")
    ```
