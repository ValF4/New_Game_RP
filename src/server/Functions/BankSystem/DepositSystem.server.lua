local RS	:ReplicatedStorage		= game:GetService("ReplicatedStorage")
local SD							= require(game:GetService("ServerScriptService").ServerData)

local CN	:RemoteEvent 			= RS:WaitForChild("Remotes").RemoteEvents.CallNotificationServer
local CDS 	:RemoteEvent 			= RS:WaitForChild("Remotes").RemoteEvents.CallDepositSystem

local db 	:table = {}

function DepositSystem(Plr, Value)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return end db[Plr.UserId]  = tick()

	local My_Data = SD.get(Plr)

	if My_Data.Money < Value then return CN:FireClient(Plr, "Valor indisponivel:", "Você não possui o valor total para o deposito", "ERROR", 3) end

	My_Data.Money -= Value
	My_Data.BankMoney += Value

	return true
end

CDS.OnServerEvent:Connect(function(Player, Value) DepositSystem(Player, Value) end)