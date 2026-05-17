local DriveThruBag_States = {}

local function findAll_DriveThruBag()
    local findAll_DriveThruBag = FindAllOf("BP_DriveThruPaperBagStack_C")
    if findAll_DriveThruBag then
        --print("Found " .. #findAll_DriveThruBag .. "  DriveThruBag Packs.")
        return findAll_DriveThruBag
    else
        --print("Found No DriveThruBag Packs")
        return nil
    end
end

local function extractID(DriveThruBag)
    local fullName = DriveThruBag:GetFullName()
    local DriveThruBag_ID = fullName:match("BP_DriveThruPaperBagStack_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(DriveThruBag_ID))
    return DriveThruBag_ID
end

local function check_DriveThruBag_StackCount()
    local DriveThruBag_s = findAll_DriveThruBag()
    if DriveThruBag_s then
        for _, DriveThruBag in pairs(DriveThruBag_s) do
            local DriveThruBag_ID = extractID(DriveThruBag)
            if DriveThruBag_ID then
                local currentPackCount = DriveThruBag:GetPropertyValue("ItemStackCount")
                local SauceType = DriveThruBag:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. DriveThruBag_ID .. "Current_count:" .. currentPackCount)
                local lastPackCount = DriveThruBag_States[DriveThruBag_ID] or 0
                if currentPackCount <=2 then
                    DriveThruBag:SetPropertyValue("ItemStackCount",20)
                end
                DriveThruBag_States[DriveThruBag_ID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    check_DriveThruBag_StackCount()
    return false
end)

print("Loaded InfiniteDriveThurBags Mod")