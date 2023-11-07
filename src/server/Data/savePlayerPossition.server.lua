local DataStoreService  = game:GetService("DataStoreService")
local PossitionStore    = DataStoreService:GetDataStore("PossitionDataStore")
local CHEKING_MODULE    = require(game:GetService("ReplicatedStorage").Shared.Functions.CHECK_SERVICE)
local SAVING_MODULE    = require(game:GetService("ServerScriptService").Server.Modules.SavePlayerDataBase)

local listPositions = {}

game.Players.PlayerAdded:Connect(function(player)
    task.wait(.5)

    local PlayerCharacter = game.Workspace:WaitForChild(player.Name)

    local success,loadValue = SAVING_MODULE.GET_DB_PLAYER(player, PossitionStore)
    
    if success then
        if loadValue then
            warn("Data loaded, please wait... ")
            PlayerCharacter:MoveTo(Vector3.new(
                loadValue[1],
                loadValue[2],
                loadValue[3]
            ))
            warn("Data loaded successfully!")
        else
            warn("No data was found in the DataStore for the player " .. player.Name)
        end
    else
        warn("Error loading data: " .. loadValue)
    end

    task.wait(5)
    while true do
        if PlayerCharacter then
            listPositions = CHEKING_MODULE.GET_POSITION_PLAYER(player)
            task.wait(5)
        else
            break
        end
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    SAVING_MODULE.SET_PLAYER_DATABASE(player, PossitionStore, listPositions)
end)


