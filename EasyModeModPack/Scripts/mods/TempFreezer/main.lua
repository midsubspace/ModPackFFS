local TempGage_States = {}

local function findAll_TempGage()
    local findAll_TempGage = FindAllOf("BP_ItemTemperatureUpdater_C")
    if findAll_TempGage then
        --print("Found " .. #findAll_TempGage .. "  TempGage Packs.")
        return findAll_TempGage
    else
        --print("Found No TempGage Packs")
        return nil
    end
end

local function extractID(TempGage)
    local fullName = TempGage:GetFullName()
    local TempGage_ID = fullName:match("BP_ItemTemperatureUpdater_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(TempGage_ID))
    return TempGage_ID
end

local function check_TempGage_StackCount()
    local TempGage_s = findAll_TempGage()
    if TempGage_s then
        for _, TempGage in pairs(TempGage_s) do
            local TempGage_ID = extractID(TempGage)
            if TempGage_ID then
                local currentPackCount = TempGage:GetPropertyValue("UpdatePerTick")
                --print("Info ID: " .. TempGage_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = TempGage_States[TempGage_ID] or 0
                if currentPackCount > 0 then
                    TempGage:SetPropertyValue("UpdatePerTick",0)
                end
                TempGage_States[TempGage_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_TempGage_StackCount()
    return false
end)

print("Loaded Temp Freezer Mod")