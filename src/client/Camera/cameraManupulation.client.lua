local ContextActionService  = game:GetService("ContextActionService")
local Players               = game:GetService("Players")
local RunService            = game:GetService("RunService")
local UserInputService      = game:GetService("UserInputService")

local camera                = workspace.CurrentCamera
local Players               = Players.LocalPlayer
local CameraOffSet          = Vector3.new(2, 2, 8)

Players.CharacterAdded:Connect(function(character)
    
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    local cameraAngleX = 0
    local cameraAngleY = 0

    local function PlayerInput(actionName, inputState, inputObject)
        if inputState == Enum.UserInputState.Change then
                cameraAngleX -=     inputObject.Delta.X
                cameraAngleY =      math.clamp(cameraAngleY - inputObject.Delta.Y * 0.4, -75, 75)
        end
    end

    ContextActionService:BindAction("PlayerInput", PlayerInput, false, Enum.UserInputType.MouseMovement, Enum.UserInputType.Touch)

    RunService:BindToRenderStep("CameraUpdate", Enum.RenderPriority.Camera.Value, function()
        local StartCFrame   =     CFrame.new(rootPart.CFrame.Position) * CFrame.Angles(0, math.rad(cameraAngleX), 0) * CFrame.Angles(math.rad(cameraAngleY), 0, 0)
        local CameraCFrame  =     StartCFrame:PointToWorldSpace(CameraOffSet)
        local CameraFocus   =     StartCFrame:PointToWorldSpace(Vector3.new(CameraOffSet.X, CameraOffSet.Y, -100000))

        camera.CFrame = CFrame.lookAt(CameraCFrame, CameraFocus)

        local lookingCFrame = CFrame.lookAt(rootPart.Position, camera.CFrame:PointToWorldSpace(Vector3.new(0, 0, -100000)))

        rootPart.CFrame = CFrame.fromMatrix(rootPart.Position, lookingCFrame.XVector, rootPart.CFrame.YVector)
    end)

end)

local function focusControl(actionName, inputState, inputObject)
    if inputState == Enum.UserInputState.Begin then
        
        camera.CameraType = Enum.CameraType.Scriptable

        UserInputService.MouseBehavior      = Enum.MouseBehavior.LockCenter
        UserInputService.MouseIconEnabled   = false
        
        ContextActionService:UnbindAction("FocusControl")
    end
end

ContextActionService:BindAction("FocusControl", focusControl, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch, Enum.UserInputType.Focus)