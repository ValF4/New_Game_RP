local DSS              = game:GetService("DataStoreService")
local PD               = DSS:GetDataStore('MyDataStore')

local ListWorks        = require(game:GetService("ReplicatedStorage").Shared.Lists.ListJobs)
local SaveModule       = require(game:GetService("ServerScriptService").Server.Modules.SavePlayerDataBase)

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
    
    warn("Loading player attributes, please wait...")
    local success, data = SaveModule.GET_DB_PLAYER(player, PD)

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
        playerWork.Value    = ListWorks["Civilian"]
        playerSubWork.Value = ListWorks["Civilian"]
        walletMoney.Value   = 5000
        bankMoney.Value     = 0
        dirtyMoney.Value    = 0
        playerLevel.Value   = 0
        xpPlayerLevel.Value = 0
        PlayerHunger.Value  = 100
        PlayerThirst.Value  = 100
        warn("Atribudos carregados com sucesso!!")
    end
end


local function playerExit(player)
    local playerStats = SaveModule.CREATE_TABLE_DB(player)
    if playerStats then
        SaveModule.SET_PLAYER_DATABASE(player, SaveModule, playerStats)
    end
end

game.Players.PlayerAdded:Connect(playerJoin)
game.Players.PlayerRemoving:Connect(playerExit)