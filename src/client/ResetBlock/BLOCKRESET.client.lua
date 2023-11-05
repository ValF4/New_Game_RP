local StarterGui = game:GetService('StarterGui')
local ResetButtonSuccess

while not ResetButtonSuccess do
	ResetButtonSuccess = pcall(StarterGui.SetCore, StarterGui, "ResetButtonCallback", false)
	task.wait()
end