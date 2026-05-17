local SodaCup_States = {}

local function findAll_SodaCup()
    local findAll_SodaCup = FindAllOf("BP_DrinkCupStack_C")
    if findAll_SodaCup then
        --print("Found " .. #findAll_SodaCup .. "  SodaCup Packs.")
        return findAll_SodaCup
    else
        --print("Found No SodaCup Packs")
        return nil
    end
end

local function extractID(SodaCup)
    local fullName = SodaCup:GetFullName()
    local SodaCup_ID = fullName:match("BP_DrinkCupStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(SodaCup_ID))
    return SodaCup_ID
end

local function check_SodaCup_StackCount()
    local SodaCup_s = findAll_SodaCup()
    if SodaCup_s then
        for _, SodaCup in pairs(SodaCup_s) do
            local SodaCup_ID = extractID(SodaCup)
            if SodaCup_ID then
                local currentPackCount = SodaCup:GetPropertyValue("ItemStackCount")
                local SauceType = SodaCup:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. SodaCup_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = SodaCup_States[SodaCup_ID] or 0
                if currentPackCount <=2 then
                    SodaCup:SetPropertyValue("ItemStackCount",40)
                end
                SodaCup_States[SodaCup_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_SodaCup_StackCount()
    return false
end)

print("Loaded EndlessSodaCups Mod")