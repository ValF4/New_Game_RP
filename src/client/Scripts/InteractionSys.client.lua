local CHEKING_MODULE        = require(game:GetService("ReplicatedStorage").Shared.Functions.CHECK_SERVICE)
local PLAYERS               = game:GetService("Players").LocalPlayer
local RunService            = game:GetService("RunService")
local UserInputService      = game:GetService("UserInputService")


RunService.RenderStepped:Connect(function()
    local CHECK_MOUSE = CHEKING_MODULE.PLAYER_ON_TOP_MOUSE(PLAYERS)
    UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
        local PRESSKEY = Enum.UserInputType.MouseButton1
        local CEKING_CLICK = CHEKING_MODULE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
        if CEKING_CLICK and CHECK_MOUSE then
            return
        end
    end)
end)









