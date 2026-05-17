local FriesLargeBox_States = {}

local function findAll_FriesLargeBox()
    local findAll_FriesLargeBox = FindAllOf("BP_FriesScoopStackLarge_C")
    if findAll_FriesLargeBox then
        --print("Found " .. #findAll_FriesLargeBox .. "  FriesLargeBox Packs.")
        return findAll_FriesLargeBox
    else
        --print("Found No FriesLargeBox Packs")
        return nil
    end
end

local function extractID(FriesLargeBox)
    local fullName = FriesLargeBox:GetFullName()
    local FriesLargeBox_ID = fullName:match("BP_FriesScoopStackLarge_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(FriesLargeBox_ID))
    return FriesLargeBox_ID
end

local function check_FriesLargeBox_StackCount()
    local FriesLargeBox_s = findAll_FriesLargeBox()
    if FriesLargeBox_s then
        for _, FriesLargeBox in pairs(FriesLargeBox_s) do
            local FriesLargeBox_ID = extractID(FriesLargeBox)
            if FriesLargeBox_ID then
                local currentPackCount = FriesLargeBox:GetPropertyValue("ItemStackCount")
                local SauceType = FriesLargeBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. FriesLargeBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = FriesLargeBox_States[FriesLargeBox_ID] or 0
                if currentPackCount <=2 then
                    FriesLargeBox:SetPropertyValue("ItemStackCount",10)
                end
                FriesLargeBox_States[FriesLargeBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_FriesLargeBox_StackCount()
    return false
end)

print("Loaded InfiniteLargeFryBoxes Mod")