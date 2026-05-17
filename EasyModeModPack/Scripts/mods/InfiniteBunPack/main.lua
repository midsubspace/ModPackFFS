local bun_packStates = {}

local function findAllbun_pack()
    local findAllbun_packs = FindAllOf("BP_BurgerBunPacket_C")
    if findAllbun_packs then
        --print("Found " .. #findAllbun_packs .. " Bun Packs.")
        return findAllbun_packs
    else
        --print("Found No Bun Packs")
        return nil
    end
end

local function extractBunPackID(bun_pack)
    local fullName = bun_pack:GetFullName()
    local bun_packID = fullName:match("BP_BurgerBunPacket_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(bun_packID))
    return bun_packID
end

local function checkbun_packCount()
    local bun_packs = findAllbun_pack()
    if bun_packs then
        for _, bun_pack in pairs(bun_packs) do
            local bun_packID = extractBunPackID(bun_pack)
            if bun_packID then
                local currentPackCount = bun_pack:GetPropertyValue("ItemStackCount")
                local SauceType = bun_pack:GetPropertyValue("ItemStackCount")
                --print("Info ID: " .. bun_packID .. "Current_count:" .. currentPackCount)
                local lastPackCount = bun_packStates[bun_packID] or 0
                if currentPackCount <=0 then
                    bun_pack:SetPropertyValue("ItemStackCount",12)
                end
                bun_packStates[bun_packID] = currentPackCount
            end
        end
    end
end
LoopAsync(100, function()
    checkbun_packCount()
    return false
end)

print("Loaded InfiniteBunPack Mod")