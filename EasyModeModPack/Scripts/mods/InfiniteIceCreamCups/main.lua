local IceCreamCup_States = {}

local function findAll_IceCreamCup()
    local findAll_IceCreamCup = FindAllOf("BP_IceCreamCupStack_C")
    if findAll_IceCreamCup then
        --print("Found " .. #findAll_IceCreamCup .. "  IceCreamCup Packs.")
        return findAll_IceCreamCup
    else
        --print("Found No IceCreamCup Packs")
        return nil
    end
end

local function extractID(IceCreamCup)
    local fullName = IceCreamCup:GetFullName()
    local IceCreamCup_ID = fullName:match("BP_IceCreamCupStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(IceCreamCup_ID))
    return IceCreamCup_ID
end

local function check_IceCreamCup_StackCount()
    local IceCreamCup_s = findAll_IceCreamCup()
    if IceCreamCup_s then
        for _, IceCreamCup in pairs(IceCreamCup_s) do
            local IceCreamCup_ID = extractID(IceCreamCup)
            if IceCreamCup_ID then
                local currentPackCount = IceCreamCup:GetPropertyValue("ItemStackCount")
                local SauceType = IceCreamCup:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. IceCreamCup_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = IceCreamCup_States[IceCreamCup_ID] or 0
                if currentPackCount <=2 then
                    IceCreamCup:SetPropertyValue("ItemStackCount",60)
                end
                IceCreamCup_States[IceCreamCup_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_IceCreamCup_StackCount()
    return false
end)

print("Loaded InfiniteIceCreamCups Mod")