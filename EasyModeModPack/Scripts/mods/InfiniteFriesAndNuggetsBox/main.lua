local FriesNuggetsBox_States = {}

local function findAll_FriesNuggetsBox()
    local findAll_FriesNuggetsBox = FindAllOf("BP_FriesNuggetsBox_C")
    if findAll_FriesNuggetsBox then
        --print("Found " .. #findAll_FriesNuggetsBox .. "  FriesNuggetsBox Packs.")
        return findAll_FriesNuggetsBox
    else
        --print("Found No FriesNuggetsBox Packs")
        return nil
    end
end

local function extractID(FriesNuggetsBox)
    local fullName = FriesNuggetsBox:GetFullName()
    local FriesNuggetsBox_ID = fullName:match("BP_FriesNuggetsBox_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(FriesNuggetsBox_ID))
    return FriesNuggetsBox_ID
end

local function check_FriesNuggetsBox_StackCount()
    local FriesNuggetsBox_s = findAll_FriesNuggetsBox()
    if FriesNuggetsBox_s then
        for _, FriesNuggetsBox in pairs(FriesNuggetsBox_s) do
            local FriesNuggetsBox_ID = extractID(FriesNuggetsBox)
            if FriesNuggetsBox_ID then
                local currentPackCount = FriesNuggetsBox:GetPropertyValue("ItemStackCount")
                local SauceType = FriesNuggetsBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. FriesNuggetsBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = FriesNuggetsBox_States[FriesNuggetsBox_ID] or 0
                if currentPackCount <=1 then
                    FriesNuggetsBox:SetPropertyValue("ItemStackCount",4)
                end
                FriesNuggetsBox_States[FriesNuggetsBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_FriesNuggetsBox_StackCount()
    return false
end)

print("Loaded Infinite Raw Fries and Nuggets Box")