local RS							= game:GetService("ReplicatedStorage")
local PS 							= game:GetService("Players").LocalPlayer
local SG							= PS:WaitForChild("PlayerGui")
local SSS							= game:GetService("ServerScriptService")

local Assets 		 				= RS:WaitForChild("Remotes")

local Modules  						= Assets:WaitForChild("Modules")
local Networks 		 				= Assets:WaitForChild("Network")

local CD 							= require(Modules.ClientData)
local CM 							= require(RS.Shared.Functions.CheckServices)

local CallNotification 				= RS:WaitForChild("Remotes").RemoteEvents.CallNotification
local CALL_OPENSENDSYSTEM 			= RS:WaitForChild("Remotes").RemoteEvents.CallOpenSendSystem
local replicated 					= RS:WaitForChild("Remotes").RemoteFunctions.FireMoneyTranferer

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
	local GetDataPlayer = CD.get(PS)
	
	TextMoneyPanel.Text = "$ " ..GetDataPlayer.Money
	SendMoneyInput.Text = "$ "

	TextMoneyPanel.InputBegan:Connect(function()
		TextMoneyPanel.Text = "$ " .. GetDataPlayer.Money
	end)

	SendBottonConfirm.MouseButton1Up:Connect(function ()
		local Value = tonumber(SendMoneyInput.Text)

		if not Value then return CallNotification:Fire("Erro na Transferencia:", "Valor invalido, favor, digitar um valor valido", "ERROR", 5) end

		if Value <= 0 then return CallNotification:Fire("Erro na Transferencia:", "Valor invalido, favor, digitar um valor valido", "ERROR", 5) end
        print(MODEL.Model)
		replicated:InvokeServer(MODEL.Model, Value)
	end)

	CloseBottonPanel.MouseButton1Up:Connect(function()
		BreakLoop = true
		SendMoneyBackground.Visible = false
	end)

	while true do
		local CHECK_MIN_DISTANCE = CM.CHECK_DISTANCE_ITEM(PS, MODEL.Model)
		if not CHECK_MIN_DISTANCE or BreakLoop then
			PS:SetAttribute("Panel", nil)
			SendMoneyBackground.Visible = false
			break
		end
		task.wait(1)
	end
end

CALL_OPENSENDSYSTEM.Event:Connect(openSendSystem)
