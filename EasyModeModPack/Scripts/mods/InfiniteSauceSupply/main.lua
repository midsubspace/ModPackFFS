local sauce_bottleStates = {}

local function findAllsauce_bottlesauces()
    local allsauce_bottlesauces = FindAllOf("BP_SauceBottle_C")
    if allsauce_bottlesauces then
        return allsauce_bottlesauces
    else
        return nil
    end
end

local function extractsauce_bottleID(sauce)
    local fullName = sauce:GetFullName()
    local sauce_bottleID = fullName:match("BP_SauceBottle_C_([%d]+)$")
    --print("Extracted little waste sauce ID: " .. tostring(sauce_bottleID))
    return sauce_bottleID
end

local function checksauce_bottleBasketSauceCount()
    local sauces = findAllsauce_bottlesauces()
    if sauces then
        for _, sauce in pairs(sauces) do
            local sauce_bottleID = extractsauce_bottleID(sauce)
            if sauce_bottleID then
                local currentSauceCount = sauce:GetPropertyValue("SauceCount")
                local SauceType = sauce:GetPropertyValue("SauceType")
                --print("Info ID: " .. sauce_bottleID .. "Current_count:" .. currentSauceCount .. "Type: " .. SauceType)
                local lastSauceCount = sauce_bottleStates[sauce_bottleID] or 15
                --print("Type:" ..SauceType)
                if currentSauceCount <= 0 then
                    sauce:SetPropertyValue("SauceCount",15)
                end
                sauce_bottleStates[sauce_bottleID] = currentSauceCount
            end
        end
    end
end
LoopAsync(100, function()
    checksauce_bottleBasketSauceCount()
    return false
end)

print("Loaded InfiniteSauceSupply Mod")