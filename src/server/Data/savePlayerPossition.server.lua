local DataStoreService = game:GetService("DataStoreService")
local PossitionStore = DataStoreService:GetDataStore("PossitionDataStore")

local listPositions = {}

function savePosition(player)
        local playerc = player.Character.Head.position
        local pos = {math.floor(playerc.X), math.floor(playerc.Y), math.floor(playerc.Z)}
    return pos
end

game.Players.PlayerAdded:Connect(function(player)
    task.wait(.5)

    local PlayerCharacter = game.Workspace:WaitForChild(player.Name)
    local character = player.Character
    local playerUserID = "Player_"..player.UserId

    local success, loadValue = pcall(function()
        return PossitionStore:GetAsync(playerUserID)
    end)
    
    if success then
        if loadValue then
            warn("Dados carregados: ")
            PlayerCharacter:MoveTo(Vector3.new(
                loadValue[1],
                loadValue[2],
                loadValue[3]
            ))
            warn("Dados carregados com sucesso")
        else
            warn("Nenhum dado foi encontrado no DataStore para o jogador " .. player.Name)
        end
    else
        warn("Erro ao carregar dados: " .. loadValue)
    end

    task.wait(5)
    while true do
        if character then
            listPositions = savePosition(player)
            task.wait(5)
        else
            break
        end
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local playerUserID = "Player_" .. player.UserId
    local success, err = pcall(function()
        return PossitionStore:SetAsync(playerUserID, listPositions)
    end)

    task.wait(.5)
    if success then
        warn("Posições salvas com sucesso!!!")
    else
        warn("Houve um erro ao salvar no banco de dados: " .. err)
    end
end)


