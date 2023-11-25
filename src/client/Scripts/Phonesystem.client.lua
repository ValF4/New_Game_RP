local Player            = game:GetService("Players").LocalPlayer
local PlayerGui         = Player:WaitForChild("PlayerGui")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")

local RemodeFolder = ReplicatedStorage:WaitForChild("Remotes")
local SharedFolder = ReplicatedStorage:WaitForChild("Shared")

local ModuleFolder = RemodeFolder:WaitForChild("Modules")

local FunctionsFolder = SharedFolder:WaitForChild("Functions")
local FolderList      = SharedFolder:WaitForChild("Lists")

local CheckServices = require(FunctionsFolder.CheckServices)
local DataStore     = require(ModuleFolder.ClientData)

-- GUI

local PhoneScreem = PlayerGui:WaitForChild("Phone")

local PhoneBackground = PhoneScreem:WaitForChild("Background")

local PhoneWallpaper = PhoneBackground:WaitForChild("Wallpaper")
local NotificationBar = PhoneBackground:WaitForChild("NotificationBar")

local TimeLabel = NotificationBar:WaitForChild("Time")

-- TweenService Config

local TweenInfo = TweenInfo.new(.3)

--Variables

local OpenPhone
local db = {}

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)

    if db[Player.UserId] and tick() - db[Player.UserId]  < .3 then return end db[Player.UserId]  = tick()

    local Key =  Enum.KeyCode.N
    local Checking_PressKey = CheckServices.PLAYER_INTERACTION(input, gameProcessedEvent, Key)
    
    if Checking_PressKey then

        if OpenPhone then --Clouse Phone
            TweenService:Create(PhoneBackground, TweenInfo, {Position = UDim2.fromScale(0.733 ,1.65)}):Play()
            task.delay(.3, function()
                Player:SetAttribute("Panel", nil)
                PhoneBackground.Visible = false
                OpenPhone = false
            end)
        else --Open Phone
            Player:SetAttribute("Panel", true)
            PhoneBackground.Visible = true
            TweenService:Create(PhoneBackground, TweenInfo, {Position = UDim2.fromScale(0.733, 1)}):Play()
            OpenPhone = true

			while true do
				local Time, _ = CheckServices.GET_TIME()
				TimeLabel.Text = string.sub(Time, 1, 5)
                task.wait(2)
            end
        end

    end
end)
