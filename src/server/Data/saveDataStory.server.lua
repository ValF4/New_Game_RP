local DataStoreService = game:GetService("DataStoreService")
local playerDatas = DataStoreService:GetDataStore('MyDataStore')

local listWorks = require(game.ReplicatedStorage.Shared.worksList.workList)

local function playerJoin(player)
    local leaderstats = player:WaitForChild('leaderstats')

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
    print(data)

    if data then
        playerName.Value    = data['PlayerName']
        playerWork.Value    = data['Work']
        playerSubWork.Value = data['subWork']
        walletMoney.Value   = data['Money']
        bankMoney.Value     = data['Bankmoney']
        dirtyMoney.Value    = data['DirtyMoney']
        playerLevel.Value   = data['PlayerLevel']
        xpPlayerLevel.Value = data['XPplayerLevel']
        PlayerHunger.Value  = data['PlayerHunger']
        PlayerThirst.Value  = data['PlayerThirst']
    else
        playerName.Value    = "nill"
        playerWork.Value    = listWorks["Civilian"]
        playerSubWork.Value = listWorks["Civilian"]
        walletMoney.Value   = 2500
        bankMoney.Value     = 0
        dirtyMoney.Value    = 0
        playerLevel.Value   = 0
        xpPlayerLevel.Value = 0
        PlayerHunger.Value  = 100
        PlayerThirst.Value  = 100
    end
end

local function createTable(player)
    local playerStats = {}
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            playerStats[stat.Name] = stat.Value
        end
    end
    return playerStats
end

local function playerExit(player)
    local vecPos =      player.Character.Head.Position
	local pos =         {math.floor(vecPos.X), math.floor(vecPos.Y), math.floor(vecPos.Z)}
    print(pos)
    local playerStats = createTable(player)
    if playerStats then
        local PlayerUserID = "Player_".. player.UserId
        local success, err = pcall(function()
            playerDatas:SetAsync(PlayerUserID, playerStats)
            print("passei aqui")
        end)
        if success then
            print("Data saved successfully.")
        else
            warn("Data save failed: " .. err)
        end
    else
        warn("Player stats table is nil.")
    end
end

game.Players.PlayerAdded:Connect(playerJoin)
game.Players.PlayerRemoving:Connect(playerExit)