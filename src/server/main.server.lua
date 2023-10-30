local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local status = DataStoreService:GetDataStore("statusplayer")
local playerDB = require(ReplicatedStorage.Shared.playersDataBase)

game.Players.PlayerAdded:Connect(function()
    print("Entrou")
end)

game.Players.PlayerRemoving:Connect(function()
    print("Saiu")
end)
