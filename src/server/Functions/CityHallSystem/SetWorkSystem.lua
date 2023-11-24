local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataServices = require(game:GetService("ServerScriptService").ServerData)

local SetWork = {}

function SetWork.Set(Player, Job)
	local GetplayerData = DataServices.get(Player)
	GetplayerData.Work = Job
	return
end

return SetWork
