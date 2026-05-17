local pattyStates = {}

local function findAllPatties()
    local allPatties = FindAllOf("BP_BeefPatty_C")
    if allPatties then
        return allPatties
    else
        return nil
    end
end


local function extractPattyID(patty)
    local fullName = patty:GetFullName()
    local pattyID = fullName:match("BP_BeefPatty_C_([%d]+)$")
    return pattyID
end

local function checkPattyDoneness()
    local patties = findAllPatties()
    if patties then
        for _, patty in pairs(patties) do
            local pattyID = extractPattyID(patty)
            if pattyID then
                local topdone = patty:GetPropertyValue("MeatTopDoneness")
                local currentTopDoneness = patty:GetPropertyValue("MeatTopDoneness")
                local currentBottomDoneness = patty:GetPropertyValue("MeatBottomDoneness")
                local lastTopDoneness = pattyStates[pattyID] or 0.0
                local lastBottomDoneness = pattyStates[pattyID] or 0.0

                if currentTopDoneness >= 0.5 and currentTopDoneness > lastTopDoneness then
                    patty:SetPropertyValue("MeatTopDoneness",0.5)
                end
                if currentBottomDoneness >= 0.5 and currentBottomDoneness > lastBottomDoneness then
                    patty:SetPropertyValue("MeatBottomDoneness",0.5)
                end

                pattyStates[pattyID] = currentTopDoneness
                pattyStates[pattyID] = currentBottomDoneness
            end
        end
    end
end
LoopAsync(100, function()
    checkPattyDoneness()
    return false
end)

print("Loaded PattyDonenessFreeze Mod")