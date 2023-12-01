local Player = game:GetService("Players").LocalPlayer
local PlayerGui	= Player:WaitForChild("PlayerGui")
local ReplicatedStorage	= game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Remotes: Folder = ReplicatedStorage:WaitForChild("Remotes")
local Modules: Folder = Remotes:WaitForChild("Modules")

local ClientData = require(Modules.ClientData)

local Hud: ScreenGui = PlayerGui:WaitForChild("Hud")

local Header: Frame = Hud:WaitForChild("Header")
local Infos: Frame = Hud:WaitForChild("Infos")

local LevelLabel: TextLabel= Header.LevelFrame.LevelLabel
local TextStatus: TextLabel = Infos.TextLabel
local MoneyLabel: TextLabel = Header.MoneyFrame.MoneyLabel
local PVLabel: TextLabel = Header.MoneyFrame.PVLabel

local format :string = "FPS: %.1f"

local frameHistory = table.create(60, 0)
local index: IntValue = 0

local GetData = ClientData.get(Player)

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

    TextStatus.Text = "Seu ID: " ..Player.UserId.. " - " ..string.format(format, math.ceil(1 / ComputeAverage())).. " - Insanity Version (0.0.1)"
end)