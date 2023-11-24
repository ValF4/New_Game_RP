local RS :ReplicatedStorage		= game:GetService("ReplicatedStorage")
local SD						= require(game:GetService("ServerScriptService").ServerData)
local CN 			        	= RS:WaitForChild("Remotes").RemoteEvents.CallNotificationServer

local CDS :RemoteEvent 			= RS:WaitForChild("Remotes").RemoteEvents.CallDepositSystem

local db :table = {}

function DepositSystem(Plr, Value)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return false end db[Plr.UserId]  = tick()

	local PlayerData = SD.get(Plr)

	if PlayerData.Money < tonumber(Value) then
		return CN:FireClient(Plr, "Deposito não realizado:", "Você não possui o valor em mãos para Deposito", "ERROR", 5)
	else
		PlayerData.Money -= Value
		PlayerData.BankMoney += Value
		CN:FireClient(Plr, "Deposito Realizado:", "Seu deposito no valor de $ " ..Value.. " foi realizado com sucesso", "SUCCESS", 5)
	end
end

CDS.OnServerEvent:Connect(function(Player, Value) DepositSystem(Player, Value) end)

