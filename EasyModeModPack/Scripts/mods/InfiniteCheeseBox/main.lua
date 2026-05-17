local CheeseBox_States = {}

local function findAll_CheeseBox()
    local findAll_CheeseBox = FindAllOf("BP_CheeseBox_C")
    if findAll_CheeseBox then
        --print("Found " .. #findAll_CheeseBox .. "  CheeseBox Packs.")
        return findAll_CheeseBox
    else
        --print("Found No CheeseBox Packs")
        return nil
    end
end

local function extractID(CheeseBox)
    local fullName = CheeseBox:GetFullName()
    local CheeseBox_ID = fullName:match("BP_CheeseBox_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(CheeseBox_ID))
    return CheeseBox_ID
end

local function check_CheeseBox_StackCount()
    local CheeseBox_s = findAll_CheeseBox()
    if CheeseBox_s then
        for _, CheeseBox in pairs(CheeseBox_s) do
            local CheeseBox_ID = extractID(CheeseBox)
            if CheeseBox_ID then
                local currentPackCount = CheeseBox:GetPropertyValue("ItemStackCount")
                local SauceType = CheeseBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. CheeseBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = CheeseBox_States[CheeseBox_ID] or 0
                if currentPackCount <=1 then
                    CheeseBox:SetPropertyValue("ItemStackCount",4)
                end
                CheeseBox_States[CheeseBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_CheeseBox_StackCount()
    return false
end)

print("Loaded Infinite Cheese Box")