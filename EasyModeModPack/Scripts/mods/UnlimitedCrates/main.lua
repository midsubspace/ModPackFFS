local Crates_States = {}

local function findAll_Crates()
    local findAll_Crates = FindAllOf("BP_CrateStack_C")
    if findAll_Crates then
        --print("Found " .. #findAll_Crates .. "  Crates Packs.")
        return findAll_Crates
    else
        --print("Found No Crates Packs")
        return nil
    end
end

local function extractID(Crates)
    local fullName = Crates:GetFullName()
    local Crates_ID = fullName:match("BP_CrateStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(Crates_ID))
    return Crates_ID
end

local function check_Crates_StackCount()
    local Crates_s = findAll_Crates()
    if Crates_s then
        for _, Crates in pairs(Crates_s) do
            local Crates_ID = extractID(Crates)
            if Crates_ID then
                local currentPackCount = Crates:GetPropertyValue("ItemStackCount")
                local SauceType = Crates:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. Crates_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = Crates_States[Crates_ID] or 0
                if currentPackCount <= 2 then
                    Crates:SetPropertyValue("ItemStackCount", 40)
                end
            
                Crates_States[Crates_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_Crates_StackCount()
    return false
end)

print("Loaded UnlimitedCrates Mod")