local SG = game:GetService('StarterGui')

local ResetButtonSuccess
local RemovePlayerList

while true do
	task.wait()
	ResetButtonSuccess, sucess = pcall(SG.SetCore, SG, "ResetButtonCallback", false)
	if ResetButtonSuccess then
		break
	end
end

while not RemovePlayerList do
	task.wait()
	RemovePlayerList =  pcall(SG.SetCoreGuiEnabled, SG, Enum.CoreGuiType.PlayerList, false)
	
	if RemovePlayerList then
		break
	end
end

