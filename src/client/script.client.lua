local object = {
    Jobs = {
        "Medico", "Mecanico", "Policial"
    },
    Salarios = {
        10000, 12000, 14000
    }
}

for n = 1, #object.Jobs, 1 do
    if object.Jobs[n] == "Policial" then
        print("Possui o Mecanico na lista")    
    else
        print("Negativo")
    end
end