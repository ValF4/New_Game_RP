local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerData = require(game:GetService("ServerScriptService").ServerData)
local CallNotificationServer: RemoteEvent = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallNotificationServer

local CallDepositSystem :RemoteEvent = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallDepositSystem

local db = {}

function DepositSystem(Plr, Value)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return false end db[Plr.UserId]  = tick()

	local PlayerData = ServerData.get(Plr)

	if PlayerData.Money < tonumber(Value) then
		return CallDepositSystem:FireClient(Plr, "Deposito não realizado:", "Você não possui o valor em mãos para Deposito", "ERROR", 5)
	else
		PlayerData.Money -= Value
		PlayerData.BankMoney += Value
		CallDepositSystem:FireClient(Plr, "Deposito Realizado:", "Seu deposito no valor de $ " ..Value.. " foi realizado com sucesso", "SUCCESS", 5)
	end
end

CallDepositSystem.OnServerEvent:Connect(function(Player, Value) DepositSystem(Player, Value) end)

