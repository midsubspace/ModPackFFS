local Wrapper_StackStates = {}

local function findAllWrapper_Stack()
    local findAllWrapper_Stacks = FindAllOf("BP_WrapperStackBox_C")
    if findAllWrapper_Stacks then
        --print("Found " .. #findAllWrapper_Stacks .. " Bun Packs.")
        return findAllWrapper_Stacks
    else
        --print("Found No Bun Packs")
        return nil
    end
end

local function extractID(Wrapper_Stack)
    local fullName = Wrapper_Stack:GetFullName()
    local Wrapper_StackID = fullName:match("BP_WrapperStackBox_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(Wrapper_StackID))
    return Wrapper_StackID
end

local function checkWrapper_StackCount()
    local Wrapper_Stacks = findAllWrapper_Stack()
    if Wrapper_Stacks then
        for _, Wrapper_Stack in pairs(Wrapper_Stacks) do
            local Wrapper_StackID = extractID(Wrapper_Stack)
            if Wrapper_StackID then
                local currentPackCount = Wrapper_Stack:GetPropertyValue("ItemStackCount")
                local SauceType = Wrapper_Stack:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. Wrapper_StackID .. "Current_count:" .. currentPackCount)
                local lastPackCount = Wrapper_StackStates[Wrapper_StackID] or 0
                if currentPackCount <=1 then
                    Wrapper_Stack:SetPropertyValue("ItemStackCount",2)
                end
                Wrapper_StackStates[Wrapper_StackID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    checkWrapper_StackCount()
    return false
end)

print("Loaded UnlimitedWrapperBoxes Mod")