local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = Player.PlayerGui

local Remotes: Folder = ReplicatedStorage:WaitForChild("Remotes")
local FolderModule: Folder = Remotes:WaitForChild("Modules")

local Remotes: Folder = ReplicatedStorage:WaitForChild("Remotes")
local PhoneRemotes: Folder = Remotes:WaitForChild("PhoneRemotes")

local Phone: ScreenGui = PlayerGui:WaitForChild("Phone")

local PhoneBackground: Frame = Phone:WaitForChild("Background")

local AplicationsFolder: Folder = PhoneBackground:WaitForChild("Aplications")

local ConfigApp: Frame= AplicationsFolder:WaitForChild("Config")

local ConfigScrolling: ScrollingFrame = ConfigApp:WaitForChild("Scrolling")

local ClientData = require(ReplicatedStorage.Remotes.Modules.ClientData)

-- Buttons
local ButtomInfos: TextButton = ConfigScrolling:WaitForChild("UserInfo")

-- Edit
local LabelName: TextLabel = ButtomInfos:WaitForChild("userName")
local InsanityAccont: TextLabel = ButtomInfos:WaitForChild("IsanityAccount")

function ConfigApp(player)

    local PlayerData = ClientData.get(Player)

    LabelName.Text = PlayerData.Name
    InsanityAccont.Text = "Insanity Acoont - ".. Player.UserId

    ButtomInfos.MouseButton1Click:Connect(function()
        print("Apertei em abrir informações")
    end)
end


PhoneRemotes.ConfigAppRemote.Event:Connect(ConfigApp)