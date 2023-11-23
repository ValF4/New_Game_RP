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
	local Target : Instance= Mouse.Target

	if not Target then return end

	local Model = Target:FindFirstAncestorOfClass("Model")
	if not Model then return end

	if not PS:GetPlayerFromCharacter(Model) then -- NPC and ATM
		local GetAttribute = Model:GetAttributes()
		if not GetAttribute["Type"] then return end
		return Model, GetAttribute
	else  -- Players
		local Humanoid =  Model:FindFirstChild("Humanoid")
		if not Humanoid then return end
		return Model
	end
end

function CHECK_SERVICE.GET_TIME()
	local Time = game:GetService("Lighting").ClockTime

	if Time == 18 or Time <= 6 then
		return "Boa noite"
	elseif Time == 6 or Time <= 12 then
		return "Bom dia"
	elseif Time == 12 or Time <= 18 then
		return "Boa tarde"
	end
end

function CHECK_SERVICE.GET_POSITION_PLAYER(PLAYER)
	local Get_Player = PLAYER.Character.Head.position
	local pos = {math.floor(Get_Player.X), math.floor(Get_Player.Y), math.floor(Get_Player.Z)}
	return pos
end

function CHECK_SERVICE.CHECK_DISTANCE_ITEM(PLAYER, ITENS)
	local MaxDistance          = 12
	local ModelPlayerTwo       = ITENS:GetPivot().Position

	return not not (PLAYER:DistanceFromCharacter(ModelPlayerTwo) <= MaxDistance)
end

return CHECK_SERVICE