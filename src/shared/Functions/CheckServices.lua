local CHECK_SERVICE = {}

function CHECK_SERVICE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
    if not GAME_PROCESSED_EVENT and INPUT.KeyCode == PRESSKEY or INPUT.UserInputType == PRESSKEY then
        return true
    else
        return false
    end
end

function CHECK_SERVICE.ON_TOP_MOUSE(PLAYER)
	local PS = game:GetService("Players")

	local Mouse = PLAYER:GetMouse()
	local Target = Mouse.Target

	if not Target then return end
	
	local Check_Atributes = Target:GetAttributes()
	--local Check_Atribute = Target:GetAttribute("Type")

	if Check_Atributes["Type"] then
		return Target, Check_Atributes
	end

	local Character = Target.Parent

	if not PS:GetPlayerFromCharacter(Character) then -- NPC e ATM
		local GetAttribute = Character:GetAttributes()
		if not GetAttribute["Type"] then return end
		return Character, GetAttribute
		
	elseif PS:GetPlayerFromCharacter(Character) then -- Players
		
		local Humanoid =  Character:FindFirstChild("Humanoid")
		if not Humanoid then return end
		return Character
	end
end

function CHECK_SERVICE.GET_PLAYER_SERVICE(PLAYER :Player)
	local Attribute = PLAYER:GetAttribute("Work")
	return Attribute
end

function CHECK_SERVICE.GET_POSITION_PLAYER(PLAYER)
    local Get_Player = PLAYER.Character.Head.position
    local pos = {math.floor(Get_Player.X), math.floor(Get_Player.Y), math.floor(Get_Player.Z)}
    return pos
end

function CHECK_SERVICE.CHECK_DISTANCE_ITEM(PLAYER, ITENS:Model)
	local MaxDistance          = 12
	local ModelPlayerTwo       = ITENS:GetPivot().Position	

	if PLAYER:DistanceFromCharacter(ModelPlayerTwo) <= MaxDistance then
        return true
    end
        return false
end

return CHECK_SERVICE