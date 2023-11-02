local time =  350

while task.wait(.1) do
    game.Lighting:SetMinutesAfterMidnight(time)
    time += .1
end