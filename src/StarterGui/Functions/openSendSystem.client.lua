local RS							= game:GetService("ReplicatedStorage")
local PS 							= game:GetService("Players").LocalPlayer
local SG							= game:GetService("StarterGui")
local SSS							= game:GetService("ServerScriptService")

local ChekingModule 				= require(RS.Shared.Functions.CheckServices)
local CallNotification 				= RS:WaitForChild("Remotes").RemoteEvents.CALL_NOTIFICATION
local CALL_OPENSENDSYSTEM 			= RS:WaitForChild("Remotes").RemoteEvents.CALL_OPEN_SEND_SYSTEM
local replicated 					= RS:WaitForChild("Remotes").RemoteFunctions.FIRE_MONEYTRANFER

local isButtonPressed: boolean    	= false
local BREAK_GUI: boolean          	= false
local LEAVE_MIN_DISTANCE: boolean 	= false

local GET_SEND_PAINEL 				= SG.SendMoneyGui.Background_PANEL
local CLOSED_GUI 					= SG.SendMoneyGui.Background_PANEL.BACKGROUND_HEADER.Close
local INPUT_VALUE 					= SG.SendMoneyGui.Background_PANEL.INPUT_VALUE
local TOTAL_MONEY 					= SG.SendMoneyGui.Background_PANEL.VALUE_MONEY


function openSendSystem(MODEL)
	
	local Get_Money = _G.PlayerData[PS.UserId]
	
	GET_SEND_PAINEL.Visible = not GET_SEND_PAINEL.Visible
	local BREAK_PANEL_GUI 	= false

	INPUT_VALUE.Text = "$ " 
	TOTAL_MONEY.Text = "$ " .. Get_Money.Status.Money


	.MouseButton1Up:Connect(function ()
		local Value = tonumber(INPUT_VALUE.Text) 

		if not Value then return CallNotification:Fire("ERROR", 10, "Erro ao trasnferir", "Valor invalido, favor, digitar um valor valido") end

		if Value <= 0 then return CallNotification:Fire("ERROR", 10, "Erro ao trasnferir", "Valor invalido, favor, digitar um valor valido") end

		local INVOKE_BANK_SYSTEM = replicated:InvokeServer(MODEL, Value)

		BREAK_PANEL_GUI = true


		if INVOKE_BANK_SYSTEM then CallNotification:Fire("SUCCESS", 5, "Sucesso ao transferir" ,"$ " .. Value .. " foi transferido com sucesso") end
	end)

	CLOSED_GUI.MouseButton1Up:Connect(function()
		GET_SEND_PAINEL.Visible = false
		isButtonPressed 		= false
	end)

	while true do
		local CHECK_MIN_DISTANCE = ChekingModule.CHECK_PLAYER_DISTANCE(PS, MODEL)
		if not CHECK_MIN_DISTANCE or BREAK_PANEL_GUI then
			GET_SEND_PAINEL.Visible = false
			BREAK_PANEL_GUI 		= true
			break
		end
		task.wait(1)
	end
end

CALL_OPENSENDSYSTEM.Event:Connect(openSendSystem)