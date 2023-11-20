local RS					= game:GetService("ReplicatedStorage")
local DataService 			= RS:WaitForChild("Remotes").RemoteFunctions.FireDataServices
local DB					= require(game:GetService("ServerScriptService").ServerData)

DataService.OnServerInvoke = function (Player)
	local GetPlayerData = DB.get(Player)
	return GetPlayerData
end
