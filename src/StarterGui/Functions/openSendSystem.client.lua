local RS							= game:GetService("ReplicatedStorage")
local PS 							= game:GetService("Players").LocalPlayer
local SG							= PS:WaitForChild("PlayerGui")
local SSS							= game:GetService("ServerScriptService")

local ChekingModule 				= require(RS.Shared.Functions.CheckServices)
local CallNotification 				= RS:WaitForChild("Remotes").RemoteEvents.CALL_NOTIFICATION
local CALL_OPENSENDSYSTEM 			= RS:WaitForChild("Remotes").RemoteEvents.CALL_OPEN_SEND_SYSTEM
local replicated 					= RS:WaitForChild("Remotes").RemoteFunctions.FIRE_MONEY_TRANFERER

local GUISendMoney 					= SG.SendMoneyGui
local SendMoneyBackground			= GUISendMoney.Background_PANEL
local SendMoneyInput				= SendMoneyBackground.INPUT_VALUE
local TextMoneyPanel				= SendMoneyBackground.VALUE_MONEY
local SendBottonConfirm				= SendMoneyBackground.ENVIAR
local CloseBottonPanel				= SendMoneyBackground.BACKGROUND_HEADER.Close


function openSendSystem(MODEL)
	local BreakLoop: boolean = false
	PS:SetAttribute("Panel", true)
	SendMoneyBackground.Visible = true

	--local My_Data = _G.PlayerData[PS.UserId]
	
	TextMoneyPanel.Text = "$ " .. PS:GetAttribute("Money")
	SendMoneyInput.Text = "$ "

	TextMoneyPanel.InputBegan:Connect(function()
		TextMoneyPanel.Text = "$ " .. PS:GetAttribute("Money")
	end)

	SendBottonConfirm.MouseButton1Up:Connect(function ()
		local Value = tonumber(SendMoneyInput.Text)

		if not Value then return CallNotification:Fire("Erro na Transferencia:", "Valor invalido, favor, digitar um valor valido", "ERROR", 5) end

		if Value <= 0 then return CallNotification:Fire("Erro na Transferencia:", "Valor invalido, favor, digitar um valor valido", "ERROR", 5) end

		local INVOKE_BANK_SYSTEM = replicated:InvokeServer(MODEL, Value)
		
		if INVOKE_BANK_SYSTEM then CallNotification:Fire("Transferencia finalizada:", "Valor o valor de $" ..Value.. " foi transferida com sucesso", "SUCCESS", 5) end
	end)

	CloseBottonPanel.MouseButton1Up:Connect(function()
		PS:SetAttribute("Panel", nil)
		BreakLoop = true
		SendMoneyBackground.Visible = false
	end)

	while true do
		local CHECK_MIN_DISTANCE = ChekingModule.CHECK_DISTANCE_ITEM(PS, MODEL)
		if not CHECK_MIN_DISTANCE or BreakLoop then
			PS:SetAttribute("Panel", nil)
			SendMoneyBackground.Visible = false
			break
		end
		task.wait(1)
	end
end

CALL_OPENSENDSYSTEM.Event:Connect(openSendSystem)
