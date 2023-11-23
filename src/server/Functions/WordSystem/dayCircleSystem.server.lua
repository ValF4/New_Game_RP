local time :IntValue =  400

while task.wait(.1) do
    game.Lighting:SetMinutesAfterMidnight(time)
    time += .01
end