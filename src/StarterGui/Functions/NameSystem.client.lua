local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CallNotification	= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotification
local CallOpenRegister	= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenRegister
local CityHallNameSet	= ReplicatedStorage:WaitForChild("Remotes").RemoteFunctions.CityHallNameSet

local CheckServices = require(ReplicatedStorage.Shared.Functions.CheckServices)

local Backgorund = PlayerGui:WaitForChild("NameGui").Background

local ConfirmButton = Backgorund.Button
local TextImput 	= Backgorund.TextBox
local CloseButton 	= Backgorund.Cabecario.cross

function OpenRegister(Model)
	local BreakLoop :boolean = false
	
	LocalPlayer:SetAttribute("Panel", true)
	Backgorund.Visible = true
	
	CloseButton.MouseButton1Down:Connect(function()
		BreakLoop = true
	end)
	
	ConfirmButton.MouseButton1Down:Connect(function()
		local GetValue = tostring(TextImput.Text)
		if GetValue == "" then
			CallNotification:Fire("Nome invalido:", "Verifique o nome digitado e tente novamente", "ERROR", 5)
		else
			local ReturnResponse = CityHallNameSet:InvokeServer(GetValue)
			if ReturnResponse then
				CallNotification:Fire("Nome Registrado:", "Nome registrado com sucesso, parabens", "SUCCESS", 5)
			end
		end
	end)
	
	while true do
		local CHECK_MIN_DISTANCE = CheckServices.CHECK_DISTANCE_ITEM(LocalPlayer, Model.Model)
		if not CHECK_MIN_DISTANCE or BreakLoop then
			LocalPlayer:SetAttribute("Panel", nil)
			Backgorund.Visible = false
			break
		end
		task.wait(1)
	end
end

CallOpenRegister.Event:Connect(OpenRegister)


