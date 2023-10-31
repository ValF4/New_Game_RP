local DataStoreService = game:GetService("DataStoreService")
local playerDatas = DataStoreService:GetDataStore('MyDataSore')
local listWorks = require(game.ReplicatedStorage.Shared.worksList.workList)
local listNames = require(game.ReplicatedStorage.Shared.listNames.listNames)

local function playerJoin(player)
    
    local leaderstats = player:WaitForChild('leaderstats')
    local Character = game.Workspace:WaitForChild(player.Name)

    local playerName    = leaderstats:WaitForChild('PlayerName')
    local playerWork    = leaderstats:WaitForChild('Work')
    local playerSubWork = leaderstats:WaitForChild('subWork')
    local walletMoney   = leaderstats:WaitForChild('Money')
    local bankMoney     = leaderstats:WaitForChild('Bankmoney')
    local dirtyMoney    = leaderstats:WaitForChild('DirtyMoney')
    local playerLevel   = leaderstats:WaitForChild('PlayerLevel')
    local xpPlayerLevel = leaderstats:WaitForChild('XPplayerLevel')
    local PlayerHunger  = leaderstats:WaitForChild('PlayerHunger')
    local PlayerThirst  = leaderstats:WaitForChild('PlayerThirst')

    local playerUserID = "Player_" .. player.UserId
    local data = playerDatas:GetAsync(playerUserID)

    if data then
        playerName      = data['PlayerName']
        playerWork      = data['Work']
        playerSubWork   = data['subWork']
        walletMoney     = data['Money']
        bankMoney       = data['Bankmoney']
        dirtyMoney      = data['DirtyMoney']
        playerLevel     = data['PlayerLevel']
        xpPlayerLevel   = data['XPplayerLevel']
        PlayerHunger    = data['PlayerHunger']
        PlayerThirst    = data['PlayerThirst']
    else
        playerName      .Value  = listNames["Lucas"]
		playerWork      .Value 	= listWorks["Civilian"]
		playerSubWork   .Value  = listWorks["Civilian"]
		walletMoney     .Value 	= 500
        bankMoney       .Value  = 0
        dirtyMoney      .Value  = 0
        playerLevel     .Value  = 0
        xpPlayerLevel   .Value  = 0
        PlayerHunger    .Value  = 100
        PlayerThirst    .Value  = 100

    end
end

local function createTable(player)
    local playerStats = {}
    for _, stat in pairs(player.leaderstats:GetChildren()) do
        playerStats[stat.Name] = stat.Value
    end
    return playerStats
end


local function saveSystem(player)
    local playerStats = createTable(player)
    local vecPos = player.Character.Head.Position
    local playerPossiton = {math.floor(vecPos.X), math.floor(vecPos.Y), math.floor(vecPos.Z)}
    local sucess, err = pcall(function()
        local PlayerUserID = "Player_".. player.UserId
        playerDatas:SetAsync(PlayerUserID, playerStats, playerPossiton)
    end)

    if not sucess then
        warn("Data save failed or could not save data")
    end
end

while wait(5) do -- Auto Saving System
    for _, player in ipairs(game.Players:GetChildren()) do
        saveSystem(player)
    end
end

game.Players.PlayerAdded:Connect(playerJoin)
game.Players.PlayerRemoving:Connect(saveSystem)