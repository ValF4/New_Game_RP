local listWorks = require(game.ReplicatedStorage.Shared.worksList.workList)

game.Players.PlayerAdded:Connect(function(player)
    
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local playerName = Instance.new("StringValue")
    playerName.Name = "PlayerName"
    playerName.Value = "nill"
    playerName.Parent = leaderstats

    local playerWork = Instance.new("StringValue")
    playerWork.Name = "Work"
    playerWork.Value = listWorks["Civilian"]
    playerWork.Parent = leaderstats

    local playerSubWork = Instance.new("StringValue")
    playerSubWork.Name = "subWork"
    playerSubWork.Value = listWorks["Civilian"]
    playerSubWork.Parent = leaderstats

    local walletMoney = Instance.new("IntValue")
    walletMoney.Name = "Money"
    walletMoney.Value = 0
    walletMoney.Parent = leaderstats

    local bankMoney = Instance.new("IntValue")
    bankMoney.Name = "Bankmoney"
    bankMoney.Value =  0
    bankMoney.Parent = leaderstats

    local dirtyMoney = Instance.new("IntValue")
    dirtyMoney.Name = "DirtyMoney"
    dirtyMoney.Value =  0
    dirtyMoney.Parent = leaderstats

    local playerLevel = Instance.new("IntValue")
    playerLevel.Name = "PlayerLevel"
    playerLevel.Value =  0
    playerLevel.Parent = leaderstats

    local xpPlayerLevel = Instance.new("IntValue")
    xpPlayerLevel.Name = "XPplayerLevel"
    xpPlayerLevel.Value =  0
    xpPlayerLevel.Parent = leaderstats

    local PlayerHunger = Instance.new("IntValue")
    PlayerHunger.Name = "PlayerHunger"
    PlayerHunger.Value =  0
    PlayerHunger.Parent = leaderstats

    local PlayerThirst = Instance.new("IntValue")
    PlayerThirst.Name = "PlayerThirst"
    PlayerThirst.Value =  0
    PlayerThirst.Parent = leaderstats
end)