local StarterGui = game:GetService('StarterGui')

local ResetButtonSuccess
local RemovePlayerList

while true do
	task.wait()
	ResetButtonSuccess, sucess = pcall(StarterGui.SetCore, StarterGui, "ResetButtonCallback", false)

	if ResetButtonSuccess then
		break
	end

end

while not RemovePlayerList do
	task.wait()
	RemovePlayerList = pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.PlayerList, false)

	if RemovePlayerList then
		break
	end
	
end

