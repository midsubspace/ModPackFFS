local FriesMedBox_States = {}

local function findAll_FriesMedBox()
    local findAll_FriesMedBox = FindAllOf("BP_FriesScoopStackMedium_C")
    if findAll_FriesMedBox then
        --print("Found " .. #findAll_FriesMedBox .. "  FriesMedBox Packs.")
        return findAll_FriesMedBox
    else
        --print("Found No FriesMedBox Packs")
        return nil
    end
end

local function extractID(FriesMedBox)
    local fullName = FriesMedBox:GetFullName()
    local FriesMedBox_ID = fullName:match("BP_FriesScoopStackMedium_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(FriesMedBox_ID))
    return FriesMedBox_ID
end

local function check_FriesMedBox_StackCount()
    local FriesMedBox_s = findAll_FriesMedBox()
    if FriesMedBox_s then
        for _, FriesMedBox in pairs(FriesMedBox_s) do
            local FriesMedBox_ID = extractID(FriesMedBox)
            if FriesMedBox_ID then
                local currentPackCount = FriesMedBox:GetPropertyValue("ItemStackCount")
                local SauceType = FriesMedBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. FriesMedBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = FriesMedBox_States[FriesMedBox_ID] or 0
                if currentPackCount <=2 then
                    FriesMedBox:SetPropertyValue("ItemStackCount",10)
                end
                FriesMedBox_States[FriesMedBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_FriesMedBox_StackCount()
    return false
end)

print("Loaded InfiniteMedFryBoxes Mod")