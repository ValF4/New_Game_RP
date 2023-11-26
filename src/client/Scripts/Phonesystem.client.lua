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
local AppLists      = require(FolderList.Appslist)

-- GUI

local PhoneScreem = PlayerGui:WaitForChild("Phone")

local PhoneBackground = PhoneScreem:WaitForChild("Background")

local PhoneWallpaper = PhoneBackground:WaitForChild("Wallpaper")
local NotificationBar = PhoneBackground:WaitForChild("NotificationBar")
local FooterBar = PhoneBackground:WaitForChild("Footer")
local MainBar = PhoneBackground:WaitForChild("Main")

local TimeLabel = NotificationBar:WaitForChild("Time")

--CloneBottons

local FooterButtomTemplate = FooterBar:WaitForChild("Template").CloneBottom
local MainButtomTemplate = MainBar:WaitForChild("Template").CloneBottom

-- TweenService Config

local TweenInfo = TweenInfo.new(.3)

--Variables

local OpenPhone
local db = {}

function CloneApps ()
	local GetApps = DataStore.get().Phone.Apps
    local n = 0

    for index, App in ((GetApps.Fixed)) do -- Footer bar Buttoms
        local GetList = AppLists.get(App)
        local Bottom = FooterButtomTemplate:Clone()
        Bottom.Name = n
        Bottom.Parent = FooterBar
        Bottom.Image = GetList.Icon
        Bottom.Visible = true
        Bottom.MouseButton1Up:Connect(function()
            GetList.Function("meu nome é ".. App)
        end)
        n += 1
    end

    for index, Mainapp in ((GetApps.Alls)) do
        local GetList = AppLists.get(Mainapp)
        local Bottom = MainButtomTemplate:Clone()
        Bottom.Name = n
        Bottom.Parent = MainBar
        Bottom.Image = GetList.Icon
        Bottom.Visible = true
        Bottom.MouseButton1Up:Connect(function()
            GetList.Function("meu nome é ".. Mainapp)
        end)
        n += 1
    end
end

function DestoryButtons()
    for index, FooterBottons in FooterBar:GetChildren() do
        if FooterBottons:IsA("ImageButton") then
			FooterBottons:Destroy()
		end
    end

    for index, MainBottons in MainBar:GetChildren() do
        if MainBottons:IsA("ImageButton") then
			MainBottons:Destroy()
		end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)

    if db[Player.UserId] and tick() - db[Player.UserId]  < .3 then return end db[Player.UserId]  = tick()

    local Key =  Enum.KeyCode.N
    local Checking_PressKey = CheckServices.PLAYER_INTERACTION(input, gameProcessedEvent, Key)
    
    if Checking_PressKey then

        if OpenPhone then --Clouse Phone
            TweenService:Create(PhoneBackground, TweenInfo, {Position = UDim2.fromScale(0.733 ,1.65)}):Play()
            task.delay(.3, function()
                DestoryButtons()
                Player:SetAttribute("Panel", nil)
                Player:SetAttribute("Phone", nil)
                PhoneBackground.Visible = false
                OpenPhone = false
            end)
        else --Open Phone
            Player:SetAttribute("Panel", true)
            Player:SetAttribute("Phone", true)
            PhoneBackground.Visible = true
            TweenService:Create(PhoneBackground, TweenInfo, {Position = UDim2.fromScale(0.733, 1)}):Play()
			OpenPhone = true
			
			CloneApps()

			while true do
				local Time, _ = CheckServices.GET_TIME()
				TimeLabel.Text = string.sub(Time, 1, 5)
                task.wait(2)
            end
        end

    end
end)
