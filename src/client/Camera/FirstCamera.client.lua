local CM        = require(game:GetService("ReplicatedStorage").Shared.Functions.CheckServices)
local IP        = game:GetService("UserInputService")
local Plr       = game.Players.LocalPlayer


local isFirstPersonMode = false

local function toggleFirstPersonMode()
    isFirstPersonMode = not isFirstPersonMode

    if isFirstPersonMode then
        Plr.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        Plr.CameraMode = Enum.CameraMode.Classic
    end
end

IP.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    local PRESSKEY = Enum.KeyCode.C
    local CEKING_MODULE = CM.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if CEKING_MODULE then
        toggleFirstPersonMode()
    end
end)


