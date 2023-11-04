local CHEKING_MODULE    = require(game:GetService("ReplicatedStorage").Shared.Functions.CHECK_SERVICE)
local PLAYER           = game:GetService("Players").LocalPlayer
local UserInputService  = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    
    local lastPrintTime = 0
    local printInterval = 1 
    local PRESSKEY      = Enum.UserInputType.MouseButton1
    local CHECK_MOUSE, MODEL   = CHEKING_MODULE.PLAYER_ON_TOP_MOUSE(PLAYER)
    local CEKING_CLICK  = CHEKING_MODULE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    local CHECK_PLAYER_DISTANCE = CHEKING_MODULE.CHECK_PLAYER_DISTANCE()

    if CEKING_CLICK and CHECK_MOUSE then
        if CHECK_PLAYER_DISTANCE then
            local currentTime = tick()
            if currentTime - lastPrintTime >= printInterval then
                print((PLAYER - MODEL).Magnitude)
                lastPrintTime = currentTime
            end
        end
    end
end)

