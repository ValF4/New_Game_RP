local RS :ReplicatedStorage			= game:GetService("ReplicatedStorage")
local SD							= require(game:GetService("ServerScriptService").ServerData)
local CN 			        		= RS:WaitForChild("Remotes").RemoteEvents.CallNotificationServer

local CWS :RemoteEvent           	= RS:WaitForChild("Remotes").RemoteEvents.CallWithdrawSystem

local db :table = {}

function withdrawSystem(Plr, Value)
	if db[Plr.UserId] and tick() - db[Plr.UserId]  < .4 then return false end db[Plr.UserId]  = tick()

	local PlayerData = SD.get(Plr)

	if PlayerData.BankMoney < Value then
		return CN:FireClient(Plr, "Saque não realizado:", "Você não possui o valor em caixa para deposito", "ERROR", 5)
	else
		PlayerData.BankMoney -= Value
		PlayerData.Money += Value
		CN:FireClient(Plr, "Saque Realizado:", "Seu saque no valor de $ " ..Value.. " foi realizado com sucesso", "SUCCESS", 5)
	end


end

CWS.OnServerEvent:Connect(function(Player, Value) withdrawSystem(Player, Value) end)
