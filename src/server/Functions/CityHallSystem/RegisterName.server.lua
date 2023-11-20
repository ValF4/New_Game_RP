local RS						= game:GetService("ReplicatedStorage")

local CHNS	:RemoteFunction 	= RS:WaitForChild("Remotes").RemoteFunctions.CityHallNameSet
local DB						= require(game:GetService("ServerScriptService").ServerData)

local db = {}

CHNS.OnServerInvoke = function (PLR, NewName)
	if db[PLR.UserId] and tick() - db[PLR.UserId]  < .4 then return end db[PLR.UserId]  = tick()
	local GetDataBase = DB.get(PLR)
	GetDataBase.Name = NewName
	return true
end