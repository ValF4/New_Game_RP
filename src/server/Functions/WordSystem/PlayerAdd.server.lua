game.Players.PlayerAdded:Connect(function(player)
    local function AddAtribbute(Character:Model)
        Character:SetAttribute("Class", )
    end

    if player.Character then
        AddAtribbute(player.Character)
    end

    player.CharacterAdded:Connect(AddAtribbute)  
end)