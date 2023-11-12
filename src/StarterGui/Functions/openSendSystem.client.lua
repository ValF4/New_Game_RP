local RS							= game:GetService("ReplicatedStorage")
local PLAYER 						= game:GetService("Players").LocalPlayer
local SG							= game:GetService("StarterGui")

local ChekingModule 				= require(RS.Shared.Functions.CheckServices)
local CallNotification 				= RS:WaitForChild("REMOTE_EVENT").CALL_NOTIFICATION
local CALL_OPENSENDSYSTEM 			= RS:WaitForChild("REMOTE_EVENT").CALL_OPEN_SEND_SYSTEM
local replicated 					= RS:WaitForChild("REMOTE_FUNCTIONS").FIRE_MONEYTRANFER

local isButtonPressed: boolean    	= false
local BREAK_GUI: boolean          	= false
local LEAVE_MIN_DISTANCE: boolean 	= false

local GET_SEND_PAINEL 				= script.Parent.Parent.SEND_MONEY_PANEL.Background_PANEL
local CLOSED_GUI 					= script.Parent.Parent.SEND_MONEY_PANEL.Background_PANEL.BACKGROUND_HEADER.Close
local INPUT_VALUE 					= script.Parent.Parent.SEND_MONEY_PANEL.Background_PANEL.INPUT_VALUE
local TOTAL_MONEY 					= script.Parent.Parent.SEND_MONEY_PANEL.Background_PANEL.VALUE_MONEY
local SEND_BOTTOM 					= script.Parent.Parent.SEND_MONEY_PANEL.Background_PANEL.ENVIAR

local Money = PLAYER:WaitForChild('leaderstats').Money

function openSendSystem(MODEL)
	
	GET_SEND_PAINEL.Visible = not GET_SEND_PAINEL.Visible
	local BREAK_PANEL_GUI 	= false

	INPUT_VALUE.Text = "$ " 
	TOTAL_MONEY.Text = "$ " .. Money.Value

	Money.Changed:Connect(function()
		TOTAL_MONEY.Text = "$ " .. Money.Value
	end)

	SEND_BOTTOM.MouseButton1Up:Connect(function ()
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
		local CHECK_MIN_DISTANCE = ChekingModule.CHECK_PLAYER_DISTANCE(PLAYER, MODEL)
		if not CHECK_MIN_DISTANCE or BREAK_PANEL_GUI then
			GET_SEND_PAINEL.Visible = false
			BREAK_PANEL_GUI 		= true
			break
		end
		task.wait(1)
	end
end

CALL_OPENSENDSYSTEM.Event:Connect(openSendSystem)