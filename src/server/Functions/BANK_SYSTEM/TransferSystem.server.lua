local CallNotification = game:GetService("ReplicatedStorage"):WaitForChild("REMOTE_EVENT").CALL_NOTIFICATION
local rs = game:GetService("ReplicatedStorage"):WaitForChild("REMOTE_FUNCTIONS").FIRE_MONEYTRANFER
local Plr = game:GetService("Players")

local db = {}

rs.OnServerInvoke = function (PLAYER, PLAYER_CHAR, VALUE)
	if db[PLAYER.UserId] and tick() - db[PLAYER.UserId]  < .4 then return end db[PLAYER.UserId]  = tick()
	
	local Plr_Receive =  Plr:GetPlayerFromCharacter(PLAYER_CHAR)

	local transferMoney 	= PLAYER:WaitForChild('leaderstats'):WaitForChild('Money')
	local ReceiveMoney 	= Plr_Receive:WaitForChild('leaderstats'):WaitForChild('Money')
	
	if transferMoney.Value < VALUE then return CallNotification:Fire("ERROR", 10, "Valor invalido, favor, digitar um valor valido") end

	transferMoney.Value -= VALUE
	ReceiveMoney.Value += VALUE
	
	return true
end
