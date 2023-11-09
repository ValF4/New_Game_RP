SAVE_MODULE = {}

function SAVE_MODULE.SET_PLAYER_DATABASE(PLAYER, DB_NAME, SAVE_INFO)
    local playerUserID = "Player_" .. PLAYER.UserId
    local success, err = pcall(function()
        return DB_NAME:SetAsync(playerUserID, SAVE_INFO)
    end)

    task.wait(.5)
    if success then
        warn("Data saved successfully.")
    else
        warn("Data save failed: " .. err)
    end
end

function SAVE_MODULE.GET_DB_PLAYER(PLAYER, DB_NAME)
    local playerUserID = "Player_" .. PLAYER.UserId
    local success, loadValue = pcall(function()
        return DB_NAME:GetAsync(playerUserID)
    end)

    return success, loadValue
end

function SAVE_MODULE.CREATE_TABLE_DB(PLAYER)
    local playerStats = {}
    local leaderstats = PLAYER:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            playerStats[stat.Name] = stat.Value
        end
    end
    return playerStats
end

return SAVE_MODULE
