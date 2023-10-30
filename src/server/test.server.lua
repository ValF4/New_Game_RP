local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerInfo = require(ReplicatedStorage.Shared.playersDataBase)

newplayer = PlayerInfo.new("Lucas Santos")
print(newplayer.playerName)
newplayer:setNamePlayer("Joao")
print(newplayer.playerName)