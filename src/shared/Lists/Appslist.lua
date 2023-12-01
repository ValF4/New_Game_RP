local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Remotes
local Remotes: Folder = ReplicatedStorage:WaitForChild("Remotes")
local PhoneRemotes: Folder = Remotes:WaitForChild("PhoneRemotes")

local TweenInfo = TweenInfo.new(.2)

local Apps = {
	
    Calculator = {
        Icon = "rbxassetid://15473934454";
        Func = function(name)
            print(name)
		end;
		
        BackgroundColor = {
            [1] = {255, 179, 0};
            [2] = {255, 85, 0};
            [3] = {186, 1, 1};
        }
    };

    Config = {
        Icon = "rbxassetid://15473943203";
        Func = function(name)
			PhoneRemotes.ConfigAppRemote:Fire(name)
		end;
		
        BackgroundColor = {
            [1] = {22, 22, 22};
            [2] = {38, 38, 38};
            [3] = {67, 67, 67};
        }
    };

    Contacts = {
        Icon = "rbxassetid://15473948051";
        Func = function(name)
            print(name)
        end;
        BackgroundColor = {
            [1] = {0, 255, 255};
            [2] = {0, 85, 255};
            [3] = {0, 83, 127};
        }
    };

    Menssager = {
        Icon = "rbxassetid://15473952523";
        Func = function(name)
            print(name)
        end;
        BackgroundColor = {
            [1] = {0, 129, 129};
            [2] = {0, 132, 255};
            [3] = {0, 116, 127};
        }
    };

    Store = {
        Icon = "rbxassetid://15473956411";
        Func = function(name)
            print(name)
        end;
        BackgroundColor = {
            [1] = {0, 170, 255};
            [2] = {0, 105, 157};
            [3] = {0, 116, 127};
        }
    }
}

function Apps.get(Name)
	local AppName = Apps[Name]
	
	if not AppName then return warn("App name Error: ", Name) end
	
	return AppName
end

function Apps.OpenAnimation(AppName, Icon, TemplateList)
	
	local App = Apps[AppName]
	
	if not App then return warn("App name Error: ", AppName) end
	
	TemplateList.Tamplate.Visible = true
	
	local GetColors = App.BackgroundColor
	
	TemplateList.UiGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(GetColors[1][1], GetColors[1][2], GetColors[1][3])),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(GetColors[2][1], GetColors[2][2], GetColors[2][3])),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(GetColors[3][1], GetColors[3][2], GetColors[3][3])),
	})
	
	TemplateList.TamplateIcon.Image = Icon
	
	TweenService:Create(TemplateList.Tamplate, TweenInfo, {Size = UDim2.fromScale(0.939, 0.956)}):Play()
	
	task.wait(1)
	
	TweenService:Create(TemplateList.Tamplate, TweenInfo, {BackgroundTransparency = 1}):Play()
	
	TweenService:Create(TemplateList.TamplateIcon, TweenInfo, {ImageTransparency = 1}):Play()
	
	task.delay(.2, function()
		TemplateList.Tamplate.Visible = false
		TemplateList.Tamplate.Size = UDim2.fromScale(0,0)
		TemplateList.Tamplate.BackgroundTransparency = 0
		TemplateList.TamplateIcon.ImageTransparency = 0
	end)
	
end

return Apps