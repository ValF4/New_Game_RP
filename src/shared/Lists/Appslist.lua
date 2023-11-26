local TweenService = game:GetService("TweenService")

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
    if not Name then return warn("Nome do aplicativo não passado.") end
    for Index, App in ((Apps)) do
        if Name == Index then return App end
    end
end

function Apps.OpenAnimation(AppName)

    TweenInfo = TweenInfo.new(5)

    for index, App in ((Apps)) do
        if AppName == index then
            print(App.BackgroundColor)
        end
    end

end

return Apps
