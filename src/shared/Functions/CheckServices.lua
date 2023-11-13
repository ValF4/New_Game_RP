local CHECK_SERVICE = {}

function CHECK_SERVICE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if not GAME_PROCESSED_EVENT and INPUT.KeyCode == PRESSKEY or INPUT.UserInputType == PRESSKEY then
        return true
    else
        return false
    end
end

function CHECK_SERVICE.PLAYER_ON_TOP_MOUSE(PLAYER)
	local Mouse = PLAYER:GetMouse()
	local Target = Mouse.Target
	
	if not Target then return end
	local Character = Target.Parent
	local Humanoid =  Character:FindFirstChild("Humanoid")
	if not Humanoid then return end
	return Character, Humanoid
	
end

function CHECK_SERVICE.ON_TOP_MOUSE(PLAYER, CLASS)
	local Mouse = PLAYER:GetMouse()
	local Target = Mouse.Target
	
	if not Target then return end
    local Check_Atribute = Target:GetAttribute(CLASS)
    if not Check_Atribute then return end
	return Target
end

function CHECK_SERVICE.GET_PLAYER_SERVICE(PLAYER :Player)
	
	local Attribute = PLAYER:GetAttribute("Work") 
	local JobLists = require(game:GetService("ReplicatedStorage").Shared.Lists.JobLists)

	return Attribute
end

function CHECK_SERVICE.GET_POSITION_PLAYER(PLAYER)
    local Get_Player = PLAYER.Character.Head.position
    local pos = {math.floor(Get_Player.X), math.floor(Get_Player.Y), math.floor(Get_Player.Z)}
    return pos
end

function CHECK_SERVICE.CHECK_PLAYER_DISTANCE(PLAYER, PLAYER_MODEL)
	local MaxDistance          = 12
	local Get_Player           = PLAYER.Character.Head.position
	local ModelPlayerTwo       = PLAYER_MODEL.Head.position
	
    local PlyersCalculateDistance = ((Get_Player - ModelPlayerTwo).Magnitude)
    if PlyersCalculateDistance <= MaxDistance then
        return true
    end
        return false
end

return CHECK_SERVICE