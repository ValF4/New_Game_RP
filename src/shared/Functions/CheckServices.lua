local CHECK_SERVICE = {}

function CHECK_SERVICE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if not GAME_PROCESSED_EVENT and INPUT.KeyCode == PRESSKEY or INPUT.UserInputType == PRESSKEY then
        return true
    else
        return false
    end
end

function CHECK_SERVICE.PLAYER_ON_TOP_MOUSE(PLAYER, CLASS)
	local Mouse = PLAYER:GetMouse()
	local Target = Mouse.Target
	
	if not Target then return end
	local Character = Target.Parent
	local Humanoid =  Character:FindFirstChild("Humanoid")
	if not Humanoid then return end
	return Character
	
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