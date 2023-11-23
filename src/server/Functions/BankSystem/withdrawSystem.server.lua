local RS :ReplicatedStorage			= game:GetService("ReplicatedStorage")

local SD							= require(game:GetService("ServerScriptService").ServerData)

local CN  :RemoteEvent				= RS:WaitForChild("Remotes").RemoteEvents.CallNotificationServer
local CWS :RemoteEvent           	= RS:WaitForChild("Remotes").RemoteEvents.CallWithdrawSystem

local db :table = {}

function withdrawSystem(Plr, Value)
	
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return end db[Plr.UserId]  = tick()

	local My_Data = SD.get(Plr)

	if My_Data.BankMoney < Value then return CN:FireClient(Plr, "Valor indisponivel:", "Você não possui o valor total em conta para Saque", "ERROR", 3) end

	My_Data.BankMoney -= Value
	My_Data.Money += Value

	return true
end

CWS.OnServerEvent:Connect(function(Player, Value) withdrawSystem(Player, Value) end)