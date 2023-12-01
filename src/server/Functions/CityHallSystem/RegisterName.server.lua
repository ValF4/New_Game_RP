local ReplicatedStorage	= game:GetService("ReplicatedStorage")

local CityHallNameSet = ReplicatedStorage:WaitForChild("Remotes").RemoteFunctions.CityHallNameSet
local ServerData = require(game:GetService("ServerScriptService").ServerData)

local db = {}

CityHallNameSet.OnServerInvoke = function (Player, NewName)
	if db[Player.UserId] and tick() - db[Player.UserId]  < .4 then return end db[Player.UserId]  = tick()
	local GetDataBase = ServerData.get(Player)
	GetDataBase.Name = NewName
	return GetDataBase.Name
end