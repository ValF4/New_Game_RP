local RS :ReplicatedStorage	= game:GetService("ReplicatedStorage")
local PS :Players			= game:GetService("Players")

local CN :RemoteEvent		= RS:WaitForChild("Remotes").RemoteEvents.CallNotification
local rs :RemoteFunction	= RS:WaitForChild("Remotes").RemoteFunctions.FireMoneyTranferer

local SD					= require(game:GetService("ServerScriptService").ServerData)

local db :table = {}

rs.OnServerInvoke = function (Plr, PLAYER_CHAR, VALUE)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return end db[Plr.UserId]  = tick()
	
	local My_Data = SD.get(Plr)
	
	if My_Data.Money < VALUE then return CN:FireClient("Valor :", "Sua transferencia foi realizada com sucesso", "SUCCESS", 3) end
	
	local Plr_Receive =  PS:GetPlayerFromCharacter(PLAYER_CHAR)
	
	if not Plr_Receive then return end
	
	local TargetData = SD.get(Plr_Receive)
	
	My_Data.Money -= VALUE
	TargetData.Money += VALUE
	
	return true
end
