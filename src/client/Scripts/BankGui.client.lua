local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Assets: Folder = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

local CallNotification = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotification
local CallOpenBanckMenu = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenBankMenu
local CallDepositSystem	= ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallDepositSystem
local CallWithdrawSystem = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallWithdrawSystem
local Modules: Folder = Assets:WaitForChild("Modules")
local Networks: Folder = Assets:WaitForChild("Network")

local CheckServices = require(ReplicatedStorage.Shared.Functions.CheckServices)
local ClientData = require(Modules.ClientData)

local BankBackground: Frame = PlayerGui:WaitForChild("BankGui").Background

--Menu
local HomeButton: ImageButton = BankBackground.Menu.home
local ExitButton: ImageButton = BankBackground.Menu.exit

--Home Gui
local HomeGui: Frame = BankBackground.Home
local DailyText: TextLabel = BankBackground.Home.Boa
local TextName: TextLabel = BankBackground.Home.PlayerName
local BalanceBackground: Frame = BankBackground.Home.balanceBackground
local OptionMenu: Frame = BankBackground.Home.Options_Menu

local OpenExtrado: TextButton = BalanceBackground.OpenBalance
local Balance: TextLabel = BalanceBackground.Saldo

local SaqueButton: TextButton = OptionMenu.SaqueButton
local TransfererButton: TextButton = OptionMenu.TransferirButton
local DepositButton: TextButton = OptionMenu.DepositarButton

-- Tranferir Menu
local TranfererGui: Frame = BankBackground.Transferir

local OneAba: TextButton = TranfererGui.History['1']

local TransferyHistoy: Frame = TranfererGui.Tranferir_Menu -- Transfery Gui Menu
local ScrollingHistory: ScrollingFrame = TranfererGui.Tranferir_Menu.ScrollingFrame
local CloneBottomHistory: TextButton = TranfererGui.Tranferir_Menu.ScrollingFrame.CloneBottom

local TransfererMenu: Frame = TranfererGui.balanceBackground

local TextSaldo: TextLabel = TransfererMenu.Value

local TranfererInput: TextBox = TransfererMenu.Transferir
local ValueInput: TextBox = TransfererMenu.InputValor

local ValueTotal :TextButton = TransfererMenu.Total
local ContinueBotton :TextButton = TransfererMenu.Continuar

--Deposit Menu

local DepositGui: Frame = BankBackground.Depositar
local DepositHistoryOne: TextButton	= DepositGui.History['1']
local DepositImput: TextBox	= DepositGui.balanceBackground.InputValor
local DepositTotal: TextButton = DepositGui.balanceBackground.Total
local ContinueDeposit: TextButton = DepositGui.balanceBackground.Continuar

--Saque Menu

local SaqueGui: Frame = BankBackground.Sacar
local SaqueHistoryOne: TextButton = SaqueGui.History['1']
local SaqueImput: TextBox = SaqueGui.balanceBackground.InputValor
local SaqueTotal : TextButton = SaqueGui.balanceBackground.Total
local ContinueSaque : TextButton = SaqueGui.balanceBackground.Continuar
local CurrentFrame: string = "Home"
local Connection

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
	if Player:GetAttribute('Panel') then return end
	if Model.Model:GetAttribute("Stolen") then
		return CallNotification:Fire("ATM violada:", "Esta ATM foi violada, volte mais tarde.", "ALERT", 5)
	end

	local GetPlayerData	= ClientData.get(Player)
	local _, GetTime = CheckServices.GET_TIME()

	Player:SetAttribute("Panel", true)

	DailyText.Text = GetTime
	TextName.Text = GetPlayerData.Name
	
	Balance.Text = "$ " ..tostring(GetPlayerData.BankMoney)
	TextSaldo.Text = "$ " ..tostring(GetPlayerData.BankMoney)

	ClientData.profileChanged.Event:Connect(function()
		Balance.Text = "$ " ..tostring(GetPlayerData.BankMoney)
		TextSaldo.Text = "$ " ..tostring(GetPlayerData.BankMoney)
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
		if CheckServices.CHECK_DISTANCE_ITEM(Player, Model.Model) then return end
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
	Player:SetAttribute("Panel", nil)
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