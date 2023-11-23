local PS 		= game:GetService("Players").LocalPlayer
local SG		= PS:WaitForChild("PlayerGui")

local RS		= game:GetService("ReplicatedStorage")
local SSS		= game:GetService("ServerScriptService")

local Assets 	= RS:WaitForChild("Remotes")

local Modules   = Assets:WaitForChild("Modules")
local Networks  = Assets:WaitForChild("Network")

local CD 		= require(Modules.ClientData)

local Hud       = SG:WaitForChild("Hud")

local Header    = Hud:WaitForChild("Header")

local LevelLabel = Header.LevelFrame.LevelLabel
local MoneyLabel = Header.MoneyFrame.MoneyLabel
local PVLabel = Header.MoneyFrame.PVLabel

local GetData = CD.get(PS)

LevelLabel.Text = GetData.Level
MoneyLabel.Text = GetData.Money .. " $"
PVLabel.Text    = GetData.BankMoney .. " $"

CD.profileChanged.Event:Connect(function()
    LevelLabel.Text = GetData.Level
    MoneyLabel.Text = GetData.Money .. " $"
    PVLabel.Text    = GetData.BankMoney .. " $"
end)