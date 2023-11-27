local TweenService = game:GetService("TweenService")

local TweenInfo = TweenInfo.new(.2)

local Apps = {
    Calculator = {
        Icon = "rbxassetid://15473934454";
        Function = function(name)
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
        Function = function(name)
            print(name)
        end;
        BackgroundColor = {
            [1] = {22, 22, 22};
            [2] = {38, 38, 38};
            [3] = {67, 67, 67};
        }
    };

    Contacts = {
        Icon = "rbxassetid://15473948051";
        Function = function(name)
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
        Function = function(name)
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
        Function = function(name)
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
    print(AppName)
	if not App then return warn("App name Error: ", AppName) end
	TemplateList.Tamplate.Visible = true
	TemplateList.UiGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(App.BackgroundColor[1][1])),
		ColorSequenceKeypoint.new(0.5, Color3.new(App.BackgroundColor[2][2])),
		ColorSequenceKeypoint.new(1, Color3.new(App.BackgroundColor[3][3])),
	}) 
	TemplateList.TamplateIcon.Image = Icon
	TweenService:Create(TemplateList.Tamplate, TweenInfo, {Size = UDim2.fromScale(0.939, 0.956)}):Play()
	task.delay(2, function ()
		TweenService:Create(TemplateList.Tamplate, TweenInfo, {Transparency = 1}):Play()
        TemplateList.Tamplate.Visible = false
		TemplateList.Tamplate = UDim2.fromScale(0,0)
	end)
   	--print(App.BackgroundColor)
   	--print(Icon)

end

return Apps

--00:47:55.195   {
--	[1] = Transition,
--	[2] = UIGradient,
--	[3] = Icon
--}  -  Cliente - Appslist:77
