local PLR 		 			= game:GetService("Players").LocalPlayer
local PG 					= PLR:WaitForChild("PlayerGui")

local RS 					= game:GetService("ReplicatedStorage")
local RC 					= game:GetService("RunService")	
local UIS 					= game:GetService("UserInputService")

local CM 				    = require(RS.Shared.Functions.CheckServices)

local CN 			        = RS:WaitForChild("Remotes").RemoteEvents.CallNotification
local CBG			  		= RS:WaitForChild("Remotes").RemoteEvents.CallOpenBankMenu
local CDS			        = RS:WaitForChild("Remotes").RemoteEvents.CallDepositSystem
local CWS			        = RS:WaitForChild("Remotes").RemoteEvents.CallWithdrawSystem

local BankPanel				= PG:WaitForChild("BankGui").Background

local Assets 		 		= game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

local Modules  				= Assets:WaitForChild("Modules")
local Networks 		 		= Assets:WaitForChild("Network")

local ClientData 			= require(Modules.ClientData)

--Menu
local HomeButton 			= BankPanel.Menu.home
local ExitButton 			= BankPanel.Menu.exit

--Home Gui
local HomeGui 				= BankPanel.Home
local DailyText          	= BankPanel.Home.Boa
local TextName 	         	= BankPanel.Home.PlayerName
local BalanceBackground 	= BankPanel.Home.balanceBackground
local OptionMenu			= BankPanel.Home.Options_Menu
local NoticeMenu			= BankPanel.Home.Notice_Menu

local OpenExtrado			= BalanceBackground.OpenBalance
local Saldo					= BalanceBackground.Saldo

local SaqueButton			= OptionMenu.SaqueButton
local TransferirButton		= OptionMenu.TransferirButton
local DepositButton			= OptionMenu.DepositarButton

-- Tranferir Menu
local TranfererGui			= BankPanel.Transferir

local OneAba				= TranfererGui.History['1']

local TransferyHistoy		= BankPanel.Transferir.Tranferir_Menu -- Transfery Gui Menu
local ScrollingHistory		= BankPanel.Transferir.Tranferir_Menu.ScrollingFrame
local CloneBottomHistory	= BankPanel.Transferir.Tranferir_Menu.ScrollingFrame.CloneBottom

local TransfererMenu		= BankPanel.Transferir.balanceBackground

local TextSaldo				= TransfererMenu.Value

local TranfererInput		= TransfererMenu.Transferir
local ValueInput			= TransfererMenu.InputValor

local ValueTotal			= TransfererMenu.Total
local ContinueBotton		= TransfererMenu.Continuar

--Deposit Menu

local DepositGui 			= BankPanel.Depositar
local DepositHistoryOne		= DepositGui.History['1']
local DepositImput			= DepositGui.balanceBackground.InputValor
local DepositTotal			= DepositGui.balanceBackground.Total
local ContinueDeposit		= DepositGui.balanceBackground.Continuar

--Saque Menu

local SaqueGui 				= BankPanel.Sacar
local SaqueHistoryOne		= SaqueGui.History['1']
local SaqueImput			= SaqueGui.balanceBackground.InputValor
local SaqueTotal			= SaqueGui.balanceBackground.Total
local ContinueSaque			= SaqueGui.balanceBackground.Continuar
local CurrentFrame 			= "Home"
local Connection 			= nil

local list = {

	Home = {
		Frame = HomeGui;
		Buttons = {
			HomeButton;
			OneAba;
			DepositHistoryOne;
			SaqueHistoryOne;
		}	
	};

	Transferer = {
		Frame = TranfererGui;
		Button = 
			TransferirButton;
	};
	
	Deposit = {
		Frame = DepositGui;
		Button = 
			DepositButton;
	};
	
	withdraw = {
		Frame = SaqueGui;
		Button = 
			SaqueButton;
	};

}

function CheckService(Input)
	if not tonumber(Input) or tonumber(Input) == 0 then return CN:Fire("Valor invalido:", "Valor digitado é invalido ou nulo.", "ERROR", 5) end
	return true
end

function OpenBankFrame(Model)
	if PLR:GetAttribute('Panel') then return end
	if Model.Model:GetAttribute("Stolen") then
		return CN:Fire("ATM violada:", "Esta ATM foi violada, volte mais tarde.", "ALERT", 5)
	end

	local PlayerDB	= ClientData.get(PLR)
	local GetTime 	= CM.GET_TIME()

	PLR:SetAttribute("Panel", true)

	DailyText.Text	  = GetTime
	TextName.Text 	  = PlayerDB.Name
	
	Saldo.Text		  = "$ " ..tostring(PlayerDB.BankMoney)
	TextSaldo.Text 	  = "$ " ..tostring(PlayerDB.BankMoney)

	ClientData.profileChanged.Event:Connect(function()
		Saldo.Text		  = "$ " ..tostring(PlayerDB.BankMoney)
		TextSaldo.Text 	  = "$ " ..tostring(PlayerDB.BankMoney)
	end)

	BankPanel.Visible = true

	local timer = 0
	
	SaqueTotal.MouseButton1Click:Connect(function() SaqueImput.Text = PlayerDB.BankMoney end)
	
	ContinueSaque.MouseButton1Click:Connect(function()
		local Check = CheckService(SaqueImput.Text)
		
		if Check then
			CWS:FireServer(tonumber(SaqueImput.Text))
		end
	end)
	
	DepositTotal.MouseButton1Click:Connect(function() DepositImput.Text = PlayerDB.Money end)

	ContinueDeposit.MouseButton1Click:Connect(function()
		local Check = CheckService(tonumber(DepositImput.Text))

		if Check then
			CDS:FireServer(tonumber(DepositImput.Text))
		end
	end)

	Connection = RC.Heartbeat:Connect(function(Step)
		timer += Step
		if timer <= 0.5 then return end
		timer = 0
		if CM.CHECK_DISTANCE_ITEM(PLR, Model.Model) then return end
		CloseBankFrame()
	end)
end

function CloseCurrentFrame()
	if CurrentFrame then
		list[CurrentFrame].Frame.Visible = false
	end
end

function CloseBankFrame()
	BankPanel.Visible = false
	PLR:SetAttribute("Panel", nil)
	Connection:Disconnect()
	CloseCurrentFrame()
	list.Home.Frame.Visible = true
	CurrentFrame = "Home"
end

for InfoName, Info in pairs(list) do
	local Frame = Info.Frame
	local function OpenFrame(Button)
		Button.MouseButton1Click:Connect(function()
			CloseCurrentFrame()
			Frame.Visible = true
			CurrentFrame = InfoName
		end)
	end
	if Info.Button then
		OpenFrame(Info.Button)
	else
		for i, Button in ipairs(Info.Buttons)  do
			OpenFrame(Button)
		end
	end
end

CBG.Event:Connect(OpenBankFrame)

ExitButton.MouseButton1Click:Connect(CloseBankFrame)