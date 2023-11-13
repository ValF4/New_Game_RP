local RS	= game:GetService("ReplicatedStorage")
local PS 	= game:GetService("Players")

local CN	= RS:WaitForChild("Remotes").RemoteEvents.CALL_NOTIFICATION
local rs	= RS:WaitForChild("Remotes").RemoteFunctions.FIRE_MONEY_TRANFERER

local db = {}

rs.OnServerInvoke = function (Plr, PLAYER_CHAR, VALUE)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return end db[Plr.UserId]  = tick()
	
	local My_Data = _G.PlayerData[Plr.UserId]
	
	if My_Data.Status.Money < VALUE then return CN:FireClient("Transferencia com sucesso:", "Sua transferencia foi realizada com sucesso", "SUCCESS", 3) end
	
	local Plr_Receive =  PS:GetPlayerFromCharacter(PLAYER_CHAR)
	
	if not Plr_Receive then return end
	
	local TargetData = _G.PlayerData[Plr_Receive.UserId]
	
	My_Data.Status.Money -= VALUE
	TargetData.Status.Money += VALUE
	
	return true
end
