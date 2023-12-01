local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local InteractionGui = PlayerGui:WaitForChild("PlayerInteractionGui")
local GetMouse = LocalPlayer:GetMouse()

local CheckServices = require(ReplicatedStorage.Shared.Functions.CheckServices)
local PlayerData = require(ReplicatedStorage.Remotes.Modules.ClientData)
local BottonList = require(ReplicatedStorage.Shared.Lists.BottonList)

local ScrollingFrame: ScrollingFrame = InteractionGui.ScrollingFrame

local isButtonPressed: boolean = false
local BreakLoop: boolean = false

local CloneButton: TextButton = InteractionGui.Botton

local Atribute
local Model

function Close()
	ScrollingFrame.Visible = false
	for v, botton in ScrollingFrame:GetChildren() do
		if botton:IsA("TextButton") then
			botton:Destroy()
		end
	end
	
	BreakLoop = true
	isButtonPressed = false
end

function CloneBotton(PlayerAtribute, Work, Model, PLR)
	local Parametros = {Model = Model}
	local n = 0
	if not PlayerAtribute then
		for NameBotton, Functions in pairs(BottonList[Work]) do
			local Bottons = CloneButton:Clone()
			Bottons.Name = n
			Bottons.Text = NameBotton
			Bottons.Parent = ScrollingFrame
			Bottons.Visible = true
			Bottons.LayoutOrder = n
			Bottons.MouseButton1Up:Connect(function()
					Functions(Parametros)
					Close()
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
			IButtons.Parent = ScrollingFrame
			IButtons.Visible = true
			IButtons.LayoutOrder = n
			IButtons.MouseButton1Up:Connect(function()
				Functions(Parametros)
				Close()
			end)
			n += 1
		end
	end
end

UserInputService.InputBegan:Connect(function(INPUT, GAME_PROCESSED_EVENT)
	
	local KeyPressed = Enum.UserInputType.MouseButton1
	local ChekingKey = CheckServices.PLAYER_INTERACTION(INPUT, GAME_PROCESSED_EVENT, KeyPressed)
	
	if not LocalPlayer:GetAttribute("Panel") and not LocalPlayer:GetAttribute("Phone") then
		
		if ChekingKey and not isButtonPressed then
			
			Model, Atribute = CheckServices.ON_TOP_MOUSE(LocalPlayer)
			
			if Model then
				isButtonPressed = true
				local PlayerJob = PlayerData.get().Work

				ScrollingFrame.Position = UDim2.new(0, GetMouse.X, 0, GetMouse.Y)
				ScrollingFrame.Visible = true
				
				CloneBotton(Atribute, PlayerJob, Model, LocalPlayer)
				
				while true do
					local distanceCheking = CheckServices.CHECK_DISTANCE_ITEM(LocalPlayer, Model)
					if not distanceCheking or BreakLoop then
						Close()
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