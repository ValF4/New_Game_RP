local CHECK_SERVICE = {}

function CHECK_SERVICE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if not GAME_PROCESSED_EVENT and INPUT.KeyCode == PRESSKEY or INPUT.UserInputType == PRESSKEY then
        return true
    else
        return false
    end
end

function CHECK_SERVICE.PLAYER_ON_TOP_MOUSE(PLAYER)
    local MOUSE                  = PLAYER:GetMouse()
    local TARGET                 = MOUSE.Target

    if TARGET and TARGET.Parent:FindFirstAncestorOfClass("Model") then
        local model = TARGET:FindFirstAncestorOfClass("Model")
        if model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Character") then
            return true, model
        else
            return false
        end
    end
    return false
end

function CHECK_SERVICE.GET_POSITION_PLAYER(PLAYER)
    local PLAYER_GET = PLAYER.Character.Head.position
    local pos = {math.floor(PLAYER_GET.X), math.floor(PLAYER_GET.Y), math.floor(PLAYER_GET.Z)}
    return pos
end

function CHECK_SERVICE.CHECK_PLAYER_DISTANCE(PLAYER, MODEL)
    local MAX_DISTANCE          = 12
    local PLAYER_GET            = PLAYER.Character.Head.position
    local MODEL_POSSITION       = MODEL.PrimaryPart.position
    local CALCULE_DISTANCE_PLAYERS = ((PLAYER_GET - MODEL_POSSITION).Magnitude)
    if CALCULE_DISTANCE_PLAYERS <= MAX_DISTANCE then
        return true
    end
        return false
end

return CHECK_SERVICE