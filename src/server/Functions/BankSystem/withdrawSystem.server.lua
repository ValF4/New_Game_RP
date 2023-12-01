local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerData = require(game:GetService("ServerScriptService").ServerData)
local CallNotificationServer = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotificationServer

local CallWithdrawSystem :RemoteEvent = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallWithdrawSystem

local db = {}

function withdrawSystem(Plr, Value)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return false end db[Plr.UserId]  = tick()

	local PlayerData = ServerData.get(Plr)

	if PlayerData.BankMoney < Value then
		return CallNotificationServer:FireClient(Plr, "Saque não realizado:", "Você não possui o valor em caixa para deposito", "ERROR", 5)
	else
		PlayerData.BankMoney -= Value
		PlayerData.Money += Value
		CallNotificationServer:FireClient(Plr, "Saque Realizado:", "Seu saque no valor de $ " ..Value.. " foi realizado com sucesso", "SUCCESS", 5)
	end

end

CallWithdrawSystem.OnServerEvent:Connect(function(Player, Value) withdrawSystem(Player, Value) end)
