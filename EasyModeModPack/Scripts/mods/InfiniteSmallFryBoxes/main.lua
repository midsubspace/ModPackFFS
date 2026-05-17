local FriesSmallBox_States = {}

local function findAll_FriesSmallBox()
    local findAll_FriesSmallBox = FindAllOf("BP_FriesScoopStackSmall_C")
    if findAll_FriesSmallBox then
        --print("Found " .. #findAll_FriesSmallBox .. "  FriesSmallBox Packs.")
        return findAll_FriesSmallBox
    else
        --print("Found No FriesSmallBox Packs")
        return nil
    end
end

local function extractID(FriesSmallBox)
    local fullName = FriesSmallBox:GetFullName()
    local FriesSmallBox_ID = fullName:match("BP_FriesScoopStackSmall_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(FriesSmallBox_ID))
    return FriesSmallBox_ID
end

local function check_FriesSmallBox_StackCount()
    local FriesSmallBox_s = findAll_FriesSmallBox()
    if FriesSmallBox_s then
        for _, FriesSmallBox in pairs(FriesSmallBox_s) do
            local FriesSmallBox_ID = extractID(FriesSmallBox)
            if FriesSmallBox_ID then
                local currentPackCount = FriesSmallBox:GetPropertyValue("ItemStackCount")
                local SauceType = FriesSmallBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. FriesSmallBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = FriesSmallBox_States[FriesSmallBox_ID] or 0
                if currentPackCount <=2 then
                    FriesSmallBox:SetPropertyValue("ItemStackCount",10)
                end
                FriesSmallBox_States[FriesSmallBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_FriesSmallBox_StackCount()
    return false
end)

print("Loaded InfiniteSmallFryBoxes Mod")