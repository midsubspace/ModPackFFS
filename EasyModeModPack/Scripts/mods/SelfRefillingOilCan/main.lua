local littlewastecanStates = {}

local function findAlllittlewastecanBaskets()
    local alllittlewastecanBaskets = FindAllOf("BP_WasteOilBarelLittle_C")
    if alllittlewastecanBaskets then
        return alllittlewastecanBaskets
    else
        return nil
    end
end

local function extractlittlewastecanID(basket)
    local fullName = basket:GetFullName()
    local littlewastecanID = fullName:match("BP_WasteOilBarelLittle_C_([%d]+)$")
    --print("Extracted little waste can ID: " .. tostring(littlewastecanID))
    return littlewastecanID
end

local function checklittlewastecanBasketWasteOil()
    local cans = findAlllittlewastecanBaskets()
    if cans then
        for _, can in pairs(cans) do
            local littlewastecanID = extractlittlewastecanID(can)
            if littlewastecanID then
                local currentWasteOil = can:GetPropertyValue("WasteOil")
                local lastWasteOil = littlewastecanStates[littlewastecanID] or 0.0
                if currentWasteOil >= 0.5 and currentWasteOil > lastWasteOil then
                    can:SetPropertyValue("WasteOil",0.0)
                end
                littlewastecanStates[littlewastecanID] = currentWasteOil
            end
        end
    end
end
LoopAsync(100, function()
    checklittlewastecanBasketWasteOil()
    return false
end)

print("Loaded SelfRefillingOilCan Mod")