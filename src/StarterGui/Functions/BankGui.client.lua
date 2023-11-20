local PLR  			                = game:GetService("Players").LocalPlayer
local PG                 			= PLR:WaitForChild("PlayerGui")

local RS							= game:GetService("ReplicatedStorage")

local ChekingModule :ModuleScript	= require(RS.Shared.Functions.CheckServices)

local CallNotification :RemoteEvent = RS:WaitForChild("Remotes").RemoteEvents.CallNotification
local CallBankGui :RemoteEvent		= RS:WaitForChild("Remotes").RemoteEvents.CallOpenBankMenu
local CallDataServices :RemoteEvent	= RS:WaitForChild("Remotes").RemoteFunctions.FireDataServices


local BankPanel						= PG:WaitForChild("BankGui").Background
local HomeButton :ImageButton		= BankPanel.Menu.home
local DailyText :TextLabel 			= BankPanel.Boa
local TextName 	:TextLabel 			= BankPanel.PlayerName
local ExitButton :TextButton		= BankPanel.Menu.exit

local BalanceBackground 			= BankPanel.balanceBackground
local OpenExtrado					= BalanceBackground.OpenBalance
local Saldo							= BalanceBackground.Saldo


local function BankSystem(PLR :Players, Model:Model)
	local BreakLoop :boolean = false
	local GetTime 			 = ChekingModule.GET_TIME()
	local PlayerDB 			 = CallDataServices:InvokeServer()
	
	PLR:SetAttribute("Panel", true)
	
	BankPanel.Visible = true
	
	DailyText.Text	  = GetTime
	TextName.Text 	  = PlayerDB.Name
	Saldo.Text		  = "$ " ..tostring(PlayerDB.Money)
	
	OpenExtrado.MouseButton1Up:Connect(function()
		print("Abri o extrado bancario")
	end)
	
	ExitButton.MouseButton1Up:Connect(function()
		BreakLoop = true
	end)
	
	while true do
		local CHECK_MIN_DISTANCE = ChekingModule.CHECK_DISTANCE_ITEM(PLR, Model)
		if not CHECK_MIN_DISTANCE or BreakLoop then
			PLR:SetAttribute("Panel", nil)
			BankPanel.Visible = false
			break
		end
		task.wait(1)
	end
end 



CallBankGui.Event:Connect(BankSystem)

