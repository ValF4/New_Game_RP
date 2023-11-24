local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui	  = LocalPlayer:WaitForChild("PlayerGui")

local ReplicatedStorage		= game:GetService("ReplicatedStorage")
local ServerScriptService	= game:GetService("ServerScriptService")

local Remotes 	= ReplicatedStorage:WaitForChild("Remotes")

local Modules   = Remotes:WaitForChild("Modules")
local Networks  = Remotes:WaitForChild("Network")

local ClientData = require(Modules.ClientData)

local Hud = PlayerGui:WaitForChild("Hud")

local Header = Hud:WaitForChild("Header")

local LevelLabel = Header.LevelFrame.LevelLabel
local MoneyLabel = Header.MoneyFrame.MoneyLabel
local PVLabel = Header.MoneyFrame.PVLabel

local GetData = ClientData.get(LocalPlayer)

LevelLabel.Text = GetData.Level
MoneyLabel.Text = GetData.Money .. " $"
PVLabel.Text    = GetData.BankMoney .. " $"

ClientData.profileChanged.Event:Connect(function()
    LevelLabel.Text = GetData.Level
    MoneyLabel.Text = GetData.Money .. " $"
    PVLabel.Text    = GetData.BankMoney .. " $"
end)