local Apps = {
    Calculator = {
        Icon = "rbxassetid://15473934454";
        Function = function(name)
            print(name)
        end;
    };

    Config = {
        Icon = "rbxassetid://15473943203";
        Function = function(name)
            print(name)
        end;
    };

    Contacts = {
        Icon = "rbxassetid://15473948051";
        Function = function(name)
            print(name)
        end;
    };

    Menssager = {
        Icon = "rbxassetid://15473952523";
        Function = function(name)
            print(name)
        end;
    };

    Store = {
        Icon = "rbxassetid://15473956411";
        Function = function(name)
            print(name)
        end;
    }
}

function Apps.get(Name)
    if not Name then return warn("Nome do aplicativo não passado.") end
    for Index, App in ((Apps)) do
        if Name == Index then return App end
    end
end

return Apps