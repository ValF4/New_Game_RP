local LocalPlayer 	= game:GetService("Players").LocalPlayer
local PlayerGui 	= LocalPlayer:WaitForChild("PlayerGui")

local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local CallNotification 		= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotification
local CallOpenBanckMenu		= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenBankMenu
local CallDepositSystem		= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallDepositSystem
local CallWithdrawSystem	= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallWithdrawSystem
local Modules  				= Assets:WaitForChild("Modules")
local Networks 		 		= Assets:WaitForChild("Network")

local CheckServices = require(ReplicatedStorage.Shared.Functions.CheckServices)
local ClientData 	= require(Modules.ClientData)

local BankBackground = PlayerGui:WaitForChild("BankGui").Background
--Menu
local HomeButton = BankBackground.Menu.home
local ExitButton = BankBackground.Menu.exit

--Home Gui
local HomeGui 			= BankBackground.Home
local DailyText         = BankBackground.Home.Boa
local TextName 	        = BankBackground.Home.PlayerName
local BalanceBackground = BankBackground.Home.balanceBackground
local OptionMenu		= BankBackground.Home.Options_Menu

local OpenExtrado		= BalanceBackground.OpenBalance
local Balance			= BalanceBackground.Saldo

local SaqueButton		= OptionMenu.SaqueButton
local TransfererButton	= OptionMenu.TransferirButton
local DepositButton		= OptionMenu.DepositarButton

-- Tranferir Menu
local TranfererGui	= BankBackground.Transferir

local OneAba = TranfererGui.History['1']

local TransferyHistoy		= BankBackground.Transferir.Tranferir_Menu -- Transfery Gui Menu
local ScrollingHistory		= BankBackground.Transferir.Tranferir_Menu.ScrollingFrame
local CloneBottomHistory	= BankBackground.Transferir.Tranferir_Menu.ScrollingFrame.CloneBottom

local TransfererMenu = BankBackground.Transferir.balanceBackground

local TextSaldo	= TransfererMenu.Value

local TranfererInput = TransfererMenu.Transferir
local ValueInput	 = TransfererMenu.InputValor

local ValueTotal	 = TransfererMenu.Total
local ContinueBotton = TransfererMenu.Continuar

--Deposit Menu

local DepositGui 		= BankBackground.Depositar
local DepositHistoryOne	= DepositGui.History['1']
local DepositImput		= DepositGui.balanceBackground.InputValor
local DepositTotal		= DepositGui.balanceBackground.Total
local ContinueDeposit	= DepositGui.balanceBackground.Continuar

--Saque Menu

local SaqueGui 		  = BankBackground.Sacar
local SaqueHistoryOne = SaqueGui.History['1']
local SaqueImput	  = SaqueGui.balanceBackground.InputValor
local SaqueTotal	  = SaqueGui.balanceBackground.Total
local ContinueSaque	  = SaqueGui.balanceBackground.Continuar
local CurrentFrame 	  = "Home"
local Connection 	  = nil

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
			TransfererButton;
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

function OpenBankFrame(Model)
	if LocalPlayer:GetAttribute('Panel') then return end
	if Model.Model:GetAttribute("Stolen") then
		return CallNotification:Fire("ATM violada:", "Esta ATM foi violada, volte mais tarde.", "ALERT", 5)
	end

	local GetPlayerData	= ClientData.get(LocalPlayer)
	local GetTime 		= CheckServices.GET_TIME()

	LocalPlayer:SetAttribute("Panel", true)

	DailyText.Text	  = GetTime
	TextName.Text 	  = GetPlayerData.Name
	
	Balance.Text	= "$ " ..tostring(GetPlayerData.BankMoney)
	TextSaldo.Text 	= "$ " ..tostring(GetPlayerData.BankMoney)

	ClientData.profileChanged.Event:Connect(function()
		Balance.Text	= "$ " ..tostring(GetPlayerData.BankMoney)
		TextSaldo.Text 	= "$ " ..tostring(GetPlayerData.BankMoney)
	end)

	BankBackground.Visible = true

	local timer = 0
	
	SaqueTotal.MouseButton1Click:Connect(function() SaqueImput.Text = GetPlayerData.BankMoney end)
	
	ContinueSaque.MouseButton1Click:Connect(function()
		local Check = CheckServices.CHECK_INPUT_SERVICE(SaqueImput.Text, "Number")
		print(Check)
		if Check then
			CallWithdrawSystem:FireServer(tonumber(SaqueImput.Text))
		else
			return CallNotification:Fire("Falha ao sacar:", "Esta ATM foi violada, volte mais tarde.", "ALERT", 5)
		end
	end)
	
	DepositTotal.MouseButton1Click:Connect(function() DepositImput.Text = GetPlayerData.Money end)

	ContinueDeposit.MouseButton1Click:Connect(function()
		local Check = CheckServices.CHECK_INPUT_SERVICE(DepositImput.Text, "Number")

		if Check then
			CallDepositSystem:FireServer(tonumber(DepositImput.Text))
		else
			return CallNotification:Fire("Falha ao depositar:", "Esta ATM foi violada, volte mais tarde.", "ALERT", 5)
		end
	end)

	Connection = RunService.Heartbeat:Connect(function(Step)
		timer += Step
		if timer <= 0.5 then return end
		timer = 0
		if CheckServices.CHECK_DISTANCE_ITEM(LocalPlayer, Model.Model) then return end
		CloseBankFrame()
	end)
end

function CloseCurrentFrame()
	if CurrentFrame then
		list[CurrentFrame].Frame.Visible = false
	end
end

function CloseBankFrame()
	BankBackground.Visible = false
	LocalPlayer:SetAttribute("Panel", nil)
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

CallOpenBanckMenu.Event:Connect(OpenBankFrame)

ExitButton.MouseButton1Click:Connect(CloseBankFrame)