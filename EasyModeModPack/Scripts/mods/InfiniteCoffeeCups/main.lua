local CoffeeCup_States = {}

local function findAll_CoffeeCup()
    local findAll_CoffeeCup = FindAllOf("BP_CoffeeCupStack_C")
    if findAll_CoffeeCup then
        --print("Found " .. #findAll_CoffeeCup .. "  CoffeeCup Packs.")
        return findAll_CoffeeCup
    else
        --print("Found No CoffeeCup Packs")
        return nil
    end
end

local function extractID(CoffeeCup)
    local fullName = CoffeeCup:GetFullName()
    local CoffeeCup_ID = fullName:match("BP_CoffeeCupStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(CoffeeCup_ID))
    return CoffeeCup_ID
end

local function check_CoffeeCup_StackCount()
    local CoffeeCup_s = findAll_CoffeeCup()
    if CoffeeCup_s then
        for _, CoffeeCup in pairs(CoffeeCup_s) do
            local CoffeeCup_ID = extractID(CoffeeCup)
            if CoffeeCup_ID then
                local currentPackCount = CoffeeCup:GetPropertyValue("ItemStackCount")
                local SauceType = CoffeeCup:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. CoffeeCup_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = CoffeeCup_States[CoffeeCup_ID] or 0
                if currentPackCount <=2 then
                    CoffeeCup:SetPropertyValue("ItemStackCount",30)
                end
                CoffeeCup_States[CoffeeCup_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_CoffeeCup_StackCount()
    return false
end)

print("Loaded InfiniteCoffeeCups Mod")