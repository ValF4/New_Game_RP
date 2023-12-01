local ReplicatedStorage	= game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer
local PlayerGui	= Player:WaitForChild("PlayerGui")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes: Folder = ReplicatedStorage:WaitForChild("Remotes")

local Modules: Folder = Remotes:WaitForChild("Modules")
local Networks: Folder = Remotes:WaitForChild("Network")

local ClientData = require(Modules.ClientData)
local CheckingServices = require(ReplicatedStorage.Shared.Functions.CheckServices)

local CallNotification = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotification
local CALL_OPENSENDSYSTEM = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenSendSystem
local replicated = ReplicatedStorage:WaitForChild("Remotes").RemoteFunctions.FireMoneyTranferer

local GUISendMoney: ScreenGui = PlayerGui.SendMoneyGui
local SendMoneyBackground: Frame = GUISendMoney.BackgroundPanel
local SendMoneyInput: TextBox = SendMoneyBackground.INPUT_VALUE
local TextMoneyPanel: TextLabel = SendMoneyBackground.VALUE_MONEY
local SendBottonConfirm: TextButton= SendMoneyBackground.ENVIAR
local CloseBottonPanel: TextButton= SendMoneyBackground.BACKGROUND_HEADER.Close

function openSendSystem(Model)
	local BreakLoop: boolean = false
	Player:SetAttribute("Panel", true)
	
	SendMoneyBackground.Visible = true
	local GetDataPlayer = ClientData.get(Player)
	
	TextMoneyPanel.Text = "$ " ..GetDataPlayer.Money
	SendMoneyInput.Text = "$ "

	TextMoneyPanel.InputBegan:Connect(function()
		TextMoneyPanel.Text = "$ " .. GetDataPlayer.Money
	end)

	SendBottonConfirm.MouseButton1Up:Connect(function ()
		local Value = tonumber(SendMoneyInput.Text)

		if not Value then return CallNotification:Fire("Erro na Transferencia:", "Valor invalido, favor, digitar um valor valido", "ERROR", 5) end

		if Value <= 0 then return CallNotification:Fire("Erro na Transferencia:", "Valor invalido, favor, digitar um valor valido", "ERROR", 5) end
        print(Model.Model)
		replicated:InvokeServer(Model.Model, Value)
	end)

	CloseBottonPanel.MouseButton1Up:Connect(function()
		BreakLoop = true
		SendMoneyBackground.Visible = false
	end)

	while true do
		local DistanceService = CheckingServices.CHECK_DISTANCE_ITEM(Player, Model.Model)
		if not DistanceService or BreakLoop then
			Player:SetAttribute("Panel", nil)
			SendMoneyBackground.Visible = false
			break
		end
		task.wait(1)
	end
end

CALL_OPENSENDSYSTEM.Event:Connect(openSendSystem)
