local UIS 			= game:GetService("UserInputService")
local RS			= game:GetService("ReplicatedStorage")
local PLR			= game:GetService("Players").LocalPlayer
local Modules 		= RS:WaitForChild("Remotes").Modules
local Network 		= RS:WaitForChild("Remotes").Network

local PG    = PLR:WaitForChild("PlayerGui")
local IQ    = PG:WaitForChild("PlayerInteractionGui")
local Mouse = PLR:GetMouse()

local CM  	= require(RS.Shared.Functions.CheckServices)
local BL	= require(RS.Shared.Lists.BottonList)
local CD	= require(Modules.ClientData)

local Interaction_Frame = IQ.ScrollingFrame

local isButtonPressed: boolean = false
local BreakLoop: boolean = false

local CloneButton = IQ.Botton

local Atribute
local Model

function CloseButton()
	Interaction_Frame.Visible = false
	for v, botton in Interaction_Frame:GetChildren() do
		if botton:IsA("TextButton") then
			botton:Destroy()
		end
	end
	BreakLoop = true
	isButtonPressed = false
end

function CloneBotton (PlayerAtribute, Work, Model, PLR)
	local Parametros = {Model = Model}
	local n = 0
	if not PlayerAtribute then
		for NameBotton, Functions in pairs(BL[Work]) do
			local Bottons = CloneButton:Clone()
			Bottons.Name = n
			Bottons.Text = NameBotton
			Bottons.Parent = Interaction_Frame
			Bottons.Visible = true
			Bottons.LayoutOrder = n
			Bottons.MouseButton1Up:Connect(function()
					Functions(Parametros)
					CloseButton()
			end)
			n += 1
 		end
	else
		local Type = Atribute["Type"]
		local SubType = Atribute.SubType
		for NameBotton, Functions in pairs(SubType and BL[Type][SubType] or BL[Type]) do
			local IButtons = CloneButton:Clone()
			IButtons.Name = n
			IButtons.Text = NameBotton
			IButtons.Parent = Interaction_Frame
			IButtons.Visible = true
			IButtons.LayoutOrder = n
			IButtons.MouseButton1Up:Connect(function()
				Functions(Parametros)
				CloseButton()
			end)
			n += 1
		end
	end
end

UIS.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
	
	local PRESSKEY 		= Enum.UserInputType.MouseButton1
	local CEKING_CLICK 	= CM.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
	
	if not PLR:GetAttribute("Panel") then
		
		if CEKING_CLICK and not isButtonPressed then
			
			Model, Atribute = CM.ON_TOP_MOUSE(PLR)
			
			if Model then
			
				local CHECK_DISTANCE_PLAYERS = CM.CHECK_DISTANCE_ITEM(PLR, Model)
				isButtonPressed = true
				local GET_WORK_PLAYER = CD.get(PLR)

				Interaction_Frame.Position 	= UDim2.new(0, Mouse.X, 0, Mouse.Y)
				Interaction_Frame.Visible 	= true
				
				CloneBotton(Atribute, GET_WORK_PLAYER.Work, Model, PLR)
				
				while true do
					local CHECK_MIN_DISTANCE = CM.CHECK_DISTANCE_ITEM(PLR, Model)
					if not CHECK_MIN_DISTANCE or BreakLoop then
						CloseButton()
						BreakLoop = false
						isButtonPressed = false
						break
					end
					task.wait(1)
				end
				
			end
		end
	end
end)