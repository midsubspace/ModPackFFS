local PickleStack_States = {}

local function findAll_PickleStack()
    local findAll_PickleStack = FindAllOf("BP_PickleStack_C")
    if findAll_PickleStack then
        --print("Found " .. #findAll_PickleStack .. "  PickleStack Packs.")
        return findAll_PickleStack
    else
        --print("Found No PickleStack Packs")
        return nil
    end
end

local function extractID(PickleStack)
    local fullName = PickleStack:GetFullName()
    local PickleStack_ID = fullName:match("BP_PickleStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(PickleStack_ID))
    return PickleStack_ID
end

local function check_PickleStack_StackCount()
    local PickleStack_s = findAll_PickleStack()
    if PickleStack_s then
        for _, PickleStack in pairs(PickleStack_s) do
            local PickleStack_ID = extractID(PickleStack)
            if PickleStack_ID then
                local currentPackCount = PickleStack:GetPropertyValue("ItemStackCount")
                local SauceType = PickleStack:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. PickleStack_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = PickleStack_States[PickleStack_ID] or 0
                if currentPackCount <=2 then
                    PickleStack:SetPropertyValue("ItemStackCount",14)
                end
                PickleStack_States[PickleStack_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_PickleStack_StackCount()
    return false
end)

print("Loaded EndlessPickles Mod")