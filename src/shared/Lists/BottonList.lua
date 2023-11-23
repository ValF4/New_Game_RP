local RS 	:ReplicatedStorage 	= game:GetService("ReplicatedStorage")

local OSS	:RemoteEvent 		= RS:WaitForChild("Remotes").RemoteEvents.CallOpenSendSystem
local COBM 	:RemoteEvent		= RS:WaitForChild("Remotes").RemoteEvents.CallOpenBankMenu
local COR 	:RemoteEvent 		= RS:WaitForChild("Remotes").RemoteEvents.CallOpenRegister

local Bottons = {

	Civilian = {
		["Transferir"] = function(...)
			OSS:Fire(...)
		end;

		["Fechar"] = function() return end; 
	};

	Emergency = {
		["Transferir"] = function(...)
			OSS:Fire(...)
		end;
		["Reviver"] = function() return end; 
		["Iniciar Tratamento"] = function() return end;
		["Fechar"] = function() return end; 
	};

	Police = {
		["Transferir"] = function(...)
			OSS:Fire(...)
		end;
		["Algemar"] = function() return end;
		["Revistar"] = function() return end;
		["Segurar"] = function() return end;
		["Fechar"] = function() return end; 
	};

	NPC = {

		Rosana = {
			["Registrar-se"] = function (...)
				COR:fire(...)
			end;
			
			["Fechar"] = function () return end
		};

	};

	ATM = {
		["Acessar banco"] = function(...)
			COBM:Fire(...)
		end;

		["Fechar"] = function() return end;
	}
}

return Bottons

