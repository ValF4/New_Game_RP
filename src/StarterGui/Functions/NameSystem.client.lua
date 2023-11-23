local PLR :Player				 = game:GetService("Players").LocalPlayer
local PG  :PlayerGui			 = PLR:WaitForChild("PlayerGui")

local RS 	:ReplicatedStorage 	 = game:GetService("ReplicatedStorage")
local CN 	:RemoteEvent		 = RS:WaitForChild("Remotes").RemoteEvents.CallNotification
local COR 	:RemoteEvent 		 = RS:WaitForChild("Remotes").RemoteEvents.CallOpenRegister
local CHNS	:RemoteFunction 	 = RS:WaitForChild("Remotes").RemoteFunctions.CityHallNameSet

local CM 			 			 = require(RS.Shared.Functions.CheckServices)

local Backgorund 				 = PG:WaitForChild("NameGui").Background

local ConfirmButton :TextButton  = Backgorund.Button
local TextImput 	:TextBox 	 = Backgorund.TextBox
local CloseButton 	:ImageButton = Backgorund.Cabecario.cross

function OpenRegister(Model)
	local BreakLoop :boolean = false
	
	PLR:SetAttribute("Panel", true)
	Backgorund.Visible = true
	
	CloseButton.MouseButton1Down:Connect(function()
		BreakLoop = true
	end)
	
	ConfirmButton.MouseButton1Down:Connect(function()
		local GetValue = tostring(TextImput.Text)
		if GetValue == "" then
			CN:Fire("Nome invalido:", "Verifique o nome digitado e tente novamente", "ERROR", 5)
		else
			local ReturnResponse = CHNS:InvokeServer(GetValue)
			if ReturnResponse then
				CN:Fire("Nome Registrado:", "Nome registrado com sucesso, parabens", "SUCCESS", 5)
			end
		end
	end)
	
	while true do
		local CHECK_MIN_DISTANCE = CM.CHECK_DISTANCE_ITEM(PLR, Model.Model)
		if not CHECK_MIN_DISTANCE or BreakLoop then
			PLR:SetAttribute("Panel", nil)
			Backgorund.Visible = false
			break
		end
		task.wait(1)
	end
end

COR.Event:Connect(OpenRegister)


