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

local Vocais = {
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
	"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
	"U", 'V', "W", "X", "Y", "Z", " "
}

function OpenRegister(Model)
	local BreakLoop :boolean = false

	LocalPlayer:SetAttribute("Panel", true)
	Backgorund.Visible = true

	CloseButton.MouseButton1Down:Connect(function()
		BreakLoop = true
	end)

	ConfirmButton.MouseButton1Down:Connect(function()

		local GetValue = tostring(TextImput.Text)
		local teste = string.split(GetValue, '')

		local LoadedName = ""

		local CheckInput = CheckServices.CHECK_INPUT_SERVICE(GetValue, "String")

		if CheckInput then
			for i, v in ((teste)) do
				if table.find(Vocais, v:upper()) then
					LoadedName..= v
				else return CallNotification:Fire("Nome invalido:", "Verifique o nome digitado e tente novamente", "ERROR", 5) end
			end
		else return CallNotification:Fire("Nome invalido:", "Verifique o nome digitado e tente novamente", "ERROR", 5) end

		local ReturnResponse = CityHallNameSet:InvokeServer(GetValue)

		if ReturnResponse then CallNotification:Fire("Nome Registrado:", "Nome registrado com sucesso, parabens", "SUCCESS", 5) end
		
		while true do
			local CHECK_MIN_DISTANCE = CheckServices.CHECK_DISTANCE_ITEM(LocalPlayer, Model.Model)
			if not CHECK_MIN_DISTANCE or BreakLoop then
				LocalPlayer:SetAttribute("Panel", nil)
				Backgorund.Visible = false
				break
			end
			task.wait(1)
		end
	end)
end

CallOpenRegister.Event:Connect(OpenRegister)


