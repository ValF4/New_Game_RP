local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local FireMoneyTranferer = ReplicatedStorage:WaitForChild("Remotes").RemoteFunctions.FireMoneyTranferer
local CallNotificationServer = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotificationServer

local ServerData = require(game:GetService("ServerScriptService").ServerData)

local db = {}

FireMoneyTranferer.OnServerInvoke = function(Plr, PLAYER_CHAR, VALUE)
	
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return end
	
	db[Plr.UserId] = tick()

	local My_Data = ServerData.get(Plr)

	if My_Data.Money < VALUE then
		return CallNotificationServer:FireClient(Plr, "Transferencia não realizada:", "Você não possui o valor em mãos para transferencia.", "ERROR", 5)
	end

	local Plr_Receive = Players:GetPlayerFromCharacter(PLAYER_CHAR)
	
	if not Plr_Receive then error(`Player not found. Found: {Plr_Receive}`) end
	
	local TargetData = ServerData.get(Plr_Receive)
	
	My_Data.Money -= VALUE
	TargetData.Money += VALUE
	
	return CallNotificationServer:FireClient(Plr, "Transferencia realizada:", "Sua transferencia no valor de $ " ..VALUE.. " foi realizada com sucesso", "SUCCESS", 5)

end