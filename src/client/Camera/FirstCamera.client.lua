local CheckServices = require(game:GetService("ReplicatedStorage").Shared.Functions.CheckServices)
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer


local isFirstPersonMode = false

local function toggleFirstPersonMode()
    isFirstPersonMode = not isFirstPersonMode

    if isFirstPersonMode then
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
    end
end

UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    local PRESSKEY = Enum.KeyCode.C
    local CEKING_MODULE = CheckServices.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if CEKING_MODULE then
        toggleFirstPersonMode()
    end
end)


