local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CallNotification = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotification
local CallOpenRegister = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenRegister
local CityHallNameSet = ReplicatedStorage:WaitForChild("Remotes").RemoteFunctions.CityHallNameSet

local CheckServices = require(ReplicatedStorage.Shared.Functions.CheckServices)

local Backgorund: Frame = PlayerGui:WaitForChild("NameGui").Background

local ConfirmButton: TextButton = Backgorund.Button
local TextImput: TextBox = Backgorund.TextBox
local CloseButton: TextButton = Backgorund.Cabecario.Close

local Vocais = {
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
	"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
	"U", 'V', "W", "X", "Y", "Z", " "
}

function OpenRegister(Model)
	local BreakLoop :boolean = false

	Player:SetAttribute("Panel", true)
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
			for _, Value in ((teste)) do
				if table.find(Vocais, Value:upper()) then
					LoadedName..= Value
				else return CallNotification:Fire("Nome invalido:", "Verifique o nome digitado e tente novamente", "ERROR", 5) end
			end
		end

		local ReturnResponse = CityHallNameSet:InvokeServer(GetValue)

		if ReturnResponse then CallNotification:Fire("Nome Registrado:", "Nome registrado com sucesso, parabens", "SUCCESS", 5) end
		
	end)

	while true do
		local CheckDistance = CheckServices.CHECK_DISTANCE_ITEM(Player, Model.Model)
		if not CheckDistance or BreakLoop then
			Player:SetAttribute("Panel", nil)
			Backgorund.Visible = false
			break
		end
		task.wait(1)
	end
end

CallOpenRegister.Event:Connect(OpenRegister)


