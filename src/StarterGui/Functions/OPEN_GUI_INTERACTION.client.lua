local RS					= game:GetService("ReplicatedStorage")
local PLAYER 				= game:GetService("Players").LocalPlayer
local StarterGui            = game:GetService("StarterGui")
local UserInputService 		= game:GetService("UserInputService")

local ChekingModule 		= require(RS.Shared.Functions.CheckServices)
local replicated 			= RS:WaitForChild("REMOTE_FUNCTIONS").FIRE_MONEYTRANFER
local CallNotification 		= RS:WaitForChild("REMOTE_EVENT").CALL_NOTIFICATION

local isButtonPressed 		= false
local BREAK_GUI 	  		= false
local LEAVE_MIN_DISTANCE 	= false

local InteractionGUI        = StarterGui.INTERACTION_GUI.PLAYER_INTERACTION_GUI
local MOUSE 				= PLAYER:GetMouse()
local FRAME_INTERACTION 	= InteractionGUI.ScrollingFrame

local GET_SEND_PAINEL 		= InteractionGUI.Parent.SEND_MONEY_PANEL.Background_PANEL
local CLOSED_GUI 			= GET_SEND_PAINEL.BACKGROUND_HEADER.clear
local INPUT_VALUE 			= GET_SEND_PAINEL.INPUT_VALUE
local TOTAL_MONEY 			= GET_SEND_PAINEL.VALUE_MONEY
local SEND_BOTTOM 			= GET_SEND_PAINEL.ENVIAR

local BOTTON_PLAYER_1 		= FRAME_INTERACTION.Money_Button
local BOTTON_PLAYER_2 		= FRAME_INTERACTION.Close_Button

local Money = PLAYER:WaitForChild('leaderstats').Money

function openSendSystem(MODEL)
	
	GET_SEND_PAINEL.Visible = true
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
		isButtonPressed = false
		BREAK_GUI 		= false
		
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
			isButtonPressed 		= false
			BREAK_GUI 				= false
			break
		end
		task.wait(1)
	end
	
end


UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
    LEAVE_MIN_DISTANCE = false
	
	local PRESSKEY 		= Enum.UserInputType.MouseButton1
	local CEKING_CLICK 	= ChekingModule.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)

    if CEKING_CLICK and not isButtonPressed then local MODEL = ChekingModule.PLAYER_ON_TOP_MOUSE(PLAYER, "Character")

        if MODEL and MODEL ~= PLAYER.Character  then local CHECK_DISTANCE_PLAYERS = ChekingModule.CHECK_PLAYER_DISTANCE(PLAYER, MODEL)

            if CHECK_DISTANCE_PLAYERS then

				isButtonPressed = true
				
				FRAME_INTERACTION.Position 	= UDim2.new(0, MOUSE.X, 0, MOUSE.Y)
				FRAME_INTERACTION.Visible 	= not FRAME_INTERACTION.Visible
				
				BOTTON_PLAYER_1.MouseButton1Up:Connect(function ()
					FRAME_INTERACTION.Visible = false
					BREAK_GUI 				  = true
					openSendSystem(MODEL)
				end)
				
				BOTTON_PLAYER_2.MouseButton1Up:Connect(function()
					FRAME_INTERACTION.Visible = false
					isButtonPressed 		  = false
					BREAK_GUI 				  = true
				end)
				
				while true do
					local CHECK_MIN_DISTANCE = ChekingModule.CHECK_PLAYER_DISTANCE(PLAYER, MODEL)
					if not CHECK_MIN_DISTANCE or BREAK_GUI then
						FRAME_INTERACTION.Visible = false
						LEAVE_MIN_DISTANCE 		  = true
						isButtonPressed 		  = false
						BREAK_GUI 				  = false
						break
					end
					task.wait(1)
				end

            end

        end

    end

end)
