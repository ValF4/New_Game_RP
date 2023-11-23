local SG = game:GetService('StarterGui')

local ResetButtonSuccess
local RemovePlayerList

while not ResetButtonSuccess and not RemovePlayerList do
	task.wait()
	RemovePlayerList =  pcall(SG.SetCoreGuiEnabled, SG, Enum.CoreGuiType.PlayerList, false) 
	ResetButtonSuccess = pcall(SG.SetCore, SG, "ResetButtonCallback", false)
end