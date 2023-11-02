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

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.C then
        toggleFirstPersonMode()
    end
end)

