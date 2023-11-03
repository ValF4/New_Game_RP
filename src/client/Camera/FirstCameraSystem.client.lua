local Cheking_Module        = require(game:GetService("ReplicatedStorage").Shared.Functions.CHECK_SERVICE)
local UserInputService      = game:GetService("UserInputService")
local Player                = game.Players.LocalPlayer


local isFirstPersonMode = false

local function toggleFirstPersonMode()
    isFirstPersonMode = not isFirstPersonMode

    if isFirstPersonMode then
        Player.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        Player.CameraMode = Enum.CameraMode.Classic
    end
end

UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    local PRESSKEY = Enum.KeyCode.C
    local CEKING_MODULE = Cheking_Module.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if CEKING_MODULE then
        toggleFirstPersonMode()
    end
end)


