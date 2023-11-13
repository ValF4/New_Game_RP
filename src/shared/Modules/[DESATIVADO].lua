local player = {} -- Desabilidado

player.__index = player

function player.new(name)
    local new = setmetatable({}, player)
    new.playerName =                name
    new.playerLife =                100
    new.playerLevel =               0
    new.experiencePlayerLevel =     0
    new.playerHunger =              100
    new.playerThirst =              100
    new.playerMoneyWallet =         500
    new.playerMoneyBank =           0
    new.playerMoneyDirty =          0
    new.PlayerWork =                ""
    return new
end

-- GETS
function player:getNamePlayer()
    return self.playerName
end

function player:getLifePlayer()
    return self.playerLife
end

function player:getExperiencePlayerLevel()
    return self.experiencePlayerLevel / 100
end

function player:getExperiencePlayer()
    return self.experienceXpPlayerLevel
end

function player:getPlayerHunger()
    return self.playerHunger
end

function player:getPlayerThirst()
    return self.playerThirst
end

function player:getPlayerMoneyWallet()
    return self.playerMoneyWallet
end

function player:getPlayerMoneyBank()
    return self.playerMoneyBank
end

function player:getPlayerMoneyDirty()
    return self.playerMoneyDirty
end

function player:getPlayerWork()
    return self.PlayerWork
end

return player



