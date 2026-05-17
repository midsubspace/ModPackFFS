local CoffeeBox_States = {}

local function findAll_CoffeeBox()
    local findAll_CoffeeBox = FindAllOf("BP_CoffeeBox_C")
    if findAll_CoffeeBox then
        --print("Found " .. #findAll_CoffeeBox .. "  CoffeeBox Packs.")
        return findAll_CoffeeBox
    else
        --print("Found No CoffeeBox Packs")
        return nil
    end
end

local function extractID(CoffeeBox)
    local fullName = CoffeeBox:GetFullName()
    local CoffeeBox_ID = fullName:match("BP_CoffeeBox_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(CoffeeBox_ID))
    return CoffeeBox_ID
end

local function check_CoffeeBox_StackCount()
    local CoffeeBox_s = findAll_CoffeeBox()
    if CoffeeBox_s then
        for _, CoffeeBox in pairs(CoffeeBox_s) do
            local CoffeeBox_ID = extractID(CoffeeBox)
            if CoffeeBox_ID then
                local currentPackCount = CoffeeBox:GetPropertyValue("ItemStackCount")
                local SauceType = CoffeeBox:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. CoffeeBox_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = CoffeeBox_States[CoffeeBox_ID] or 0
                if currentPackCount <=1 then
                    CoffeeBox:SetPropertyValue("ItemStackCount",2)
                end
                CoffeeBox_States[CoffeeBox_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_CoffeeBox_StackCount()
    return false
end)

print("Loaded Infinite Coffee Box")