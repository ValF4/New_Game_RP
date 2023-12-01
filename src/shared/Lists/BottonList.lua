local ReplicatedStorage :ReplicatedStorage = game:GetService("ReplicatedStorage")

local OpenSendSystem	:RemoteEvent = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenSendSystem
local CallOpenBankMenu 	:RemoteEvent = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenBankMenu
local CallOpenRegister 	:RemoteEvent = ReplicatedStorage:WaitForChild("Remotes").RemoteEvents.CallOpenRegister

local Bottons = {

	Civilian = {
		["Transferir"] = function(...)
			OpenSendSystem:Fire(...)
		end;

		["Fechar"] = function() return end; 
	};

	Emergency = {
		["Transferir"] = function(...)
			OpenSendSystem:Fire(...)
		end;
		["Reviver"] = function() return end; 
		["Iniciar Tratamento"] = function() return end;
		["Fechar"] = function() return end; 
	};

	Police = {
		["Transferir"] = function(...)
			OpenSendSystem:Fire(...)
		end;
		["Algemar"] = function() return end;
		["Revistar"] = function() return end;
		["Segurar"] = function() return end;
		["Fechar"] = function() return end; 
	};

	NPC = {

		Rosana = {
			["Registrar-se"] = function (...)
				CallOpenRegister:fire(...)
			end;
			
			["Fechar"] = function () return end
		};

	};

	ATM = {
		["Acessar banco"] = function(...)
			CallOpenBankMenu:Fire(...)
		end;

		["Fechar"] = function() return end;
	}
}

return Bottons

