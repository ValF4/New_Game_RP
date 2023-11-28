local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage	= game:GetService("ReplicatedStorage")
local LocalPlayer		= game:GetService("Players").LocalPlayer

local PlayerGui 		   = LocalPlayer:WaitForChild("PlayerGui")
local PlayerInteractionGui = PlayerGui:WaitForChild("PlayerInteractionGui")
local GetMouse 			   = LocalPlayer:GetMouse()

local CheckServices = require(ReplicatedStorage.Shared.Functions.CheckServices)
local BottonList	= require(ReplicatedStorage.Shared.Lists.BottonList)

local Interaction_Frame = PlayerInteractionGui.ScrollingFrame

local isButtonPressed: boolean = false
local BreakLoop: boolean = false

local CloneButton = PlayerInteractionGui.Botton

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
		for NameBotton, Functions in pairs(BottonList[Work]) do
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
		for NameBotton, Functions in pairs(SubType and BottonList[Type][SubType] or BottonList[Type]) do
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

UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
	
	local PRESSKEY 		= Enum.UserInputType.MouseButton1
	local CEKING_CLICK 	= CheckServices.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, PRESSKEY)
	
	if not LocalPlayer:GetAttribute("Panel") and not LocalPlayer:GetAttribute("Phone") then
		
		if CEKING_CLICK and not isButtonPressed then
			
			Model, Atribute = CheckServices.ON_TOP_MOUSE(LocalPlayer)
			
			if Model then
				isButtonPressed = true
				local PlayerJob = CheckServices.GET_PLAYER_WORK(LocalPlayer)

				Interaction_Frame.Position 	= UDim2.new(0, GetMouse.X, 0, GetMouse.Y)
				Interaction_Frame.Visible 	= true
				
				CloneBotton(Atribute, PlayerJob, Model, LocalPlayer)
				
				while true do
					local CHECK_MIN_DISTANCE = CheckServices.CHECK_DISTANCE_ITEM(LocalPlayer, Model)
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