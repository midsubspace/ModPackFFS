local fryerStates = {}

local function findAllFryerBaskets()
    local allFryerBaskets = FindAllOf("BP_FryerBasket_C")
    if allFryerBaskets then
        return allFryerBaskets
    else
        return nil
    end
end

local function extractFryerID(basket)
    local fullName = basket:GetFullName()
    local fryerID = fullName:match("BP_FryerBasket_C_([%d]+)$")
    return fryerID
end

local function checkFryerBasketDoneness()
    local baskets = findAllFryerBaskets()
    if baskets then
        for _, basket in pairs(baskets) do
            local fryerID = extractFryerID(basket)
            if fryerID then
                local currentDoneness = basket:GetPropertyValue("Doneness")
                local lastDoneness = fryerStates[fryerID] or 0.0
                if currentDoneness >= 0.5 and currentDoneness > lastDoneness then
                    basket:SetPropertyValue("Doneness",0.5)
                end
                fryerStates[fryerID] = currentDoneness
            end
        end
    end
end
LoopAsync(100, function()
    checkFryerBasketDoneness()
    return false
end)

print("Loaded FryerDonenessFreeze Mod")