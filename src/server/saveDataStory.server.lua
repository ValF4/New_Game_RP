local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local playerDatas = DataStoreService:GetDataStore('MyDataSore')

local function playerJoin(player)
    
    local leaderstats = player:WaitForChild('leaderstats')

    local playerName    = leaderstats:WaitForChild('Name')
    local playerName    = leaderstats:WaitForChild('Possition')
    local playerWork    = leaderstats:WaitForChild('Work')
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
        playerName      = data['Name']
        playerName      = data['Possition']
        playerWork      = data['Work']
        walletMoney     = data['Money']
        bankMoney       = data['Bankmoney']
        dirtyMoney      = data['DirtyMoney']
        playerLevel     = data['PlayerLevel']
        xpPlayerLevel   = data['XPplayerLevel']
        PlayerHunger    = data['PlayerHunger']
        PlayerThirst    = data['PlayerThirst']
    else
        playerName.value    = Players.Name
        playerName.value    = -63.69, 4.038, -29.378
		playerWork.value 	= "Civilian"
		walletMoney.value 	= 500
        bankMoney.value     = 0
        dirtyMoney.value    = 0
        playerLevel.value   = 0
        xpPlayerLevel.value = 0
        PlayerHunger.value  = 100
        PlayerThirst.value  = 100

    end
end

local function createTable(player)
    local playerStats = {}
    for _, stat in pairs(player.leaderstats:GetChidren()) do
        
    end
end