local CHEKING_MODULE    = require(game:GetService("ReplicatedStorage").Shared.Functions.CHECK_SERVICE)
local PLAYER           = game:GetService("Players").LocalPlayer
local UserInputService  = game:GetService("UserInputService")


UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    local MAX_DISTANCE                      = 12
    local PRESSKEY                          = Enum.UserInputType.MouseButton1
    local CEKING_CLICK                      = CHEKING_MODULE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)

    if CEKING_CLICK then
        local CHECK_MOUSE, MODEL            = CHEKING_MODULE.PLAYER_ON_TOP_MOUSE(PLAYER)
        if CHECK_MOUSE then
            local CHECK_DISTANCE_PLAYERS    = CHEKING_MODULE.CHECK_PLAYER_DISTANCE(PLAYER, MODEL, MAX_DISTANCE)
            if  CHECK_DISTANCE_PLAYERS then
                print("A")
            end
        end
    end
end)
    
