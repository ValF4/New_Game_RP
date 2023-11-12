local Cheking_Module        = require(game:GetService("ReplicatedStorage").Shared.Functions.CheckServices)
local InputService          = game:GetService("UserInputService")
local Plr                   = game.Players.LocalPlayer


local isFirstPersonMode = false

local function toggleFirstPersonMode()
    isFirstPersonMode = not isFirstPersonMode

    if isFirstPersonMode then
        Plr.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        Plr.CameraMode = Enum.CameraMode.Classic
    end
end

InputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    local PRESSKEY = Enum.KeyCode.C
    local CEKING_MODULE = Cheking_Module.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if CEKING_MODULE then
        toggleFirstPersonMode()
    end
end)


