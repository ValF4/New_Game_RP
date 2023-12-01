local CheckServices = require(game:GetService("ReplicatedStorage").Shared.Functions.CheckServices)
local UserInputService = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer

local isFirstPersonMode: boolean = false

local function toggleFirstPersonMode()
    isFirstPersonMode = not isFirstPersonMode

    if isFirstPersonMode then
        Player.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        Player.CameraMode = Enum.CameraMode.Classic
    end
end

UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
    local keyPressed = Enum.KeyCode.C
    local ClickService = CheckServices.PLAYER_INTERACTION(Input, GameProcessedEvent, keyPressed)
    if ClickService then
        toggleFirstPersonMode()
    end
end)


