local Players = game:GetService("Players")

local distanciaMaxima = 10

local function calcularDistancia(jogador1, jogador2)
    local pos1 = jogador1.Character and jogador1.Character.PrimaryPart and jogador1.Character.PrimaryPart.Position
    local pos2 = jogador2.Character and jogador2.Character.PrimaryPart and jogador2.Character.PrimaryPart.Position

    if pos1 and pos2 then
        return (pos1 - pos2).Magnitude
    else
        return math.huge
    end
end

local function verificarProximidade(jogadorLocal)
    while true do
        local jogadorMaisProximo = nil
        local distanciaMinima = math.huge

        for _, jogador in pairs(game.Players:GetPlayers()) do
            if jogador ~= jogadorLocal then
                local distancia = calcularDistancia(jogadorLocal, jogador)
                if distancia < distanciaMinima then
                    jogadorMaisProximo = jogador
                    distanciaMinima = distancia
                end
            end
        end
        if jogadorMaisProximo and distanciaMinima <= distanciaMaxima then

            print("O jogador mais próximo está dentro da distância máxima.")
        else
            print("O jogador mais próximo está fora da distância máxima.")
        end

        task.Wait(1) 
    end
end

verificarProximidade(Players)
