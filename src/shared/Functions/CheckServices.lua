local ReplicatedStorage	= game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Remotes").Modules
local Network = ReplicatedStorage:WaitForChild("Remotes").Network

local DataService = require(Modules.ClientData)

local checkingServices = {}

function checkingServices.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
	if not GAME_PROCESSED_EVENT and INPUT.KeyCode == PRESSKEY or INPUT.UserInputType == PRESSKEY then
		return true
	else
		return false
	end
end

function checkingServices.CHECK_INPUT_SERVICE(INPUT, Type)
	
	if Type == "String" then
		if not tostring(INPUT) or tostring(INPUT) == "" then return false
		else
			return true
		end
	end

	if Type == "Number" then
		if not tonumber(INPUT) or tonumber(INPUT) == 0 then return false
		else
			return true
		end
	end

end

function checkingServices.ON_TOP_MOUSE(PLAYER)
	local Players = game:GetService("Players")

	local Mouse = PLAYER:GetMouse()
	local Target = Mouse.Target

	if not Target then return end

	local Model :Model = Target:FindFirstAncestorOfClass("Model")
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

function checkingServices.GET_TIME()
	local GetTime = game:GetService("Lighting").ClockTime
	local TimeOfDay = game:GetService("Lighting").TimeOfDay

	if GetTime == 18 or GetTime <= 6 then
		return TimeOfDay, "Boa noite"
	elseif GetTime == 6 or GetTime <= 12 then
		return TimeOfDay, "Bom dia"
	elseif GetTime == 12 or GetTime <= 18 then
		return TimeOfDay, "Boa tarde"
	end
end

function checkingServices.GET_POSITION_PLAYER(PLAYER)
	local GetPlayerPossition = PLAYER.Character.Head.position
	local pos = {math.floor(GetPlayerPossition.X), math.floor(GetPlayerPossition.Y), math.floor(GetPlayerPossition.Z)}
	return pos
end

function checkingServices.CHECK_DISTANCE_ITEM(PLAYER, ITENS)
	local MaxDistance          = 12
	local ModelPlayerTwo       = ITENS:GetPivot().Position

	return not not (PLAYER:DistanceFromCharacter(ModelPlayerTwo) <= MaxDistance)
end

return checkingServices