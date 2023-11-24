local ReplicatedStorage	= game:GetService("ReplicatedStorage")

local Modules 	= ReplicatedStorage:WaitForChild("Remotes").Modules
local Network 	= ReplicatedStorage:WaitForChild("Remotes").Network

local DataService	= require(Modules.ClientData)

local CHECK_SERVICE = {}

function CHECK_SERVICE.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
	if not GAME_PROCESSED_EVENT and INPUT.KeyCode == PRESSKEY or INPUT.UserInputType == PRESSKEY then
		return true
	else
		return false
	end
end

function CHECK_SERVICE.GET_PLAYER_WORK(Player) return DataService.get(Player).Work end

function CHECK_SERVICE.ON_TOP_MOUSE(PLAYER)
	local Players = game:GetService("Players")

	local Mouse = PLAYER:GetMouse()
	local Target : Instance= Mouse.Target

	if not Target then return end

	local Model = Target:FindFirstAncestorOfClass("Model")
	if not Model then return end

	if not Players:GetPlayerFromCharacter(Model) then -- NPC and ATM
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
	local GetTime = game:GetService("Lighting").ClockTime

	if GetTime == 18 or GetTime <= 6 then
		return "Boa noite"
	elseif GetTime == 6 or GetTime <= 12 then
		return "Bom dia"
	elseif GetTime == 12 or GetTime <= 18 then
		return "Boa tarde"
	end
end

function CHECK_SERVICE.GET_POSITION_PLAYER(PLAYER)
	local GetPlayerPossition = PLAYER.Character.Head.position
	local pos = {math.floor(GetPlayerPossition.X), math.floor(GetPlayerPossition.Y), math.floor(GetPlayerPossition.Z)}
	return pos
end

function CHECK_SERVICE.CHECK_DISTANCE_ITEM(PLAYER, ITENS)
	local MaxDistance          = 12
	local ModelPlayerTwo       = ITENS:GetPivot().Position

	return not not (PLAYER:DistanceFromCharacter(ModelPlayerTwo) <= MaxDistance)
end

return CHECK_SERVICE