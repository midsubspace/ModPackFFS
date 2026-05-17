local PattyBox_States = {}

local function findAll_PattyBox()
    local findAll_PattyBox = FindAllOf("BP_PattyBox_C")
    if findAll_PattyBox then
        --print("Found " .. #findAll_PattyBox .. "  PattyBox Packs.")
        return findAll_PattyBox
    else
        --print("Found No PattyBox Packs")
        return nil
    end
end

local function extractID(PattyBox)
    local fullName = PattyBox:GetFullName()
    local PattyBox_ID = fullName:match("BP_PattyBox_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(PattyBox_ID))
    return PattyBox_ID
end

local function check_PattyBox_StackCount()
    local PattyBox_s = findAll_PattyBox()
    if PattyBox_s then
        for _, PattyBox in pairs(PattyBox_s) do
            local PattyBox_ID = extractID(PattyBox)
            if PattyBox_ID then
                local currentPackCount = PattyBox:GetPropertyValue("ItemStackCount")
                local SauceType = PattyBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. PattyBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = PattyBox_States[PattyBox_ID] or 0
                if currentPackCount <=1 then
                    PattyBox:SetPropertyValue("ItemStackCount",2)
                end
                PattyBox_States[PattyBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_PattyBox_StackCount()
    return false
end)

print("Loaded Infinite Patty Box")