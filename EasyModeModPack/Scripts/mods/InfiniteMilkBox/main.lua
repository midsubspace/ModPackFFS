local MilkBox_States = {}

local function findAll_MilkBox()
    local findAll_MilkBox = FindAllOf("BP_MilkBox_C")
    if findAll_MilkBox then
        --print("Found " .. #findAll_MilkBox .. "  MilkBox Packs.")
        return findAll_MilkBox
    else
        --print("Found No MilkBox Packs")
        return nil
    end
end

local function extractID(MilkBox)
    local fullName = MilkBox:GetFullName()
    local MilkBox_ID = fullName:match("BP_MilkBox_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(MilkBox_ID))
    return MilkBox_ID
end

local function check_MilkBox_StackCount()
    local MilkBox_s = findAll_MilkBox()
    if MilkBox_s then
        for _, MilkBox in pairs(MilkBox_s) do
            local MilkBox_ID = extractID(MilkBox)
            if MilkBox_ID then
                local currentPackCount = MilkBox:GetPropertyValue("ItemStackCount")
                local SauceType = MilkBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. MilkBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = MilkBox_States[MilkBox_ID] or 0
                if currentPackCount <=1 then
                    MilkBox:SetPropertyValue("ItemStackCount",4)
                end
                MilkBox_States[MilkBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_MilkBox_StackCount()
    return false
end)

print("Loaded Infinite Milk Box")