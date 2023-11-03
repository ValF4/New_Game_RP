local CHECK_SERVICE = {}

function CHECK_SERVICE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    local KEY_CECKING = PRESSKEY
    if not GAME_PROCESSED_EVENT and INPUT.KeyCode == KEY_CECKING or INPUT.UserInputType == KEY_CECKING then
        return true
    else
        return false
    end
end

function CHECK_SERVICE.PLAYER_ON_TOP_MOUSE(PLAYERS)
    local MOUSE                  = PLAYERS:GetMouse()
    local TARGET                 = MOUSE.Target

    if TARGET and TARGET.Parent:FindFirstAncestorOfClass("Model") then
        local model = TARGET:FindFirstAncestorOfClass("Model")
        if model:FindFirstChild("Humanoid") then
            return true
        else
            return false
        end
    end
end

function CHECK_SERVICE.CHECK_PLAYER_DISTANCE()
    return
end

return CHECK_SERVICE