local NuggetBoxStack_States = {}

local function findAll_NuggetBoxStack()
    local findAll_NuggetBoxStack = FindAllOf("BP_NuggetBoxStack_C")
    if findAll_NuggetBoxStack then
        --print("Found " .. #findAll_NuggetBoxStack .. "  NuggetBoxStack Packs.")
        return findAll_NuggetBoxStack
    else
        --print("Found No NuggetBoxStack Packs")
        return nil
    end
end

local function extractID(NuggetBoxStack)
    local fullName = NuggetBoxStack:GetFullName()
    local NuggetBoxStack_ID = fullName:match("BP_NuggetBoxStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(NuggetBoxStack_ID))
    return NuggetBoxStack_ID
end

local function check_NuggetBoxStack_StackCount()
    local NuggetBoxStack_s = findAll_NuggetBoxStack()
    if NuggetBoxStack_s then
        for _, NuggetBoxStack in pairs(NuggetBoxStack_s) do
            local NuggetBoxStack_ID = extractID(NuggetBoxStack)
            if NuggetBoxStack_ID then
                local currentPackCount = NuggetBoxStack:GetPropertyValue("ItemStackCount")
                local SauceType = NuggetBoxStack:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. NuggetBoxStack_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = NuggetBoxStack_States[NuggetBoxStack_ID] or 0
                if currentPackCount <=2 then
                    NuggetBoxStack:SetPropertyValue("ItemStackCount",20)
                end
                NuggetBoxStack_States[NuggetBoxStack_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_NuggetBoxStack_StackCount()
    return false
end)

print("Loaded InfiniteNuggetBox Mod")