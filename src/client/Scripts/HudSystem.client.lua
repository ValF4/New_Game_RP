local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui	  = LocalPlayer:WaitForChild("PlayerGui")

local ReplicatedStorage		= game:GetService("ReplicatedStorage")
local RunService            = game:GetService("RunService")
local ServerScriptService	= game:GetService("ServerScriptService")


local Remotes 	= ReplicatedStorage:WaitForChild("Remotes")

local Modules   = Remotes:WaitForChild("Modules")
local Networks  = Remotes:WaitForChild("Network")

local ClientData = require(Modules.ClientData)

local Hud = PlayerGui:WaitForChild("Hud")

local Header = Hud:WaitForChild("Header")
local Infos = Hud:WaitForChild("Infos")

local LevelLabel = Header.LevelFrame.LevelLabel
local TextStatus = Infos.TextLabel
local MoneyLabel = Header.MoneyFrame.MoneyLabel
local PVLabel = Header.MoneyFrame.PVLabel

local format = "FPS: %.1f"

local frameHistory = table.create(60, 0)
local index = 0

local GetData = ClientData.get(LocalPlayer)

LevelLabel.Text = GetData.Level
MoneyLabel.Text = GetData.Money .. " $"
PVLabel.Text    = GetData.BankMoney .. " $"

local function ComputeAverage()
	local average = 0

	for _, deltaTime in ((frameHistory)) do
		average += deltaTime
	end

	return average / 60
end

ClientData.profileChanged.Event:Connect(function()
    LevelLabel.Text = GetData.Level
    MoneyLabel.Text = GetData.Money .. " $"
    PVLabel.Text    = GetData.BankMoney .. " $"
end)


RunService.Heartbeat:Connect(function(deltaTime)
    index = (index + 1) % 61

    frameHistory[index] = deltaTime

    TextStatus.Text = "Seu ID: " ..LocalPlayer.UserId.. " - " ..string.format(format, math.ceil(1 / ComputeAverage())).. " - Insanity Version (0.0.1)"
end)