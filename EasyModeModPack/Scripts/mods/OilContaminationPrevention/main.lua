local GassFryer_States = {}

local function findAll_GassFryer()
    local findAll_GassFryer = FindAllOf("BP_GasFryer_C")
    if findAll_GassFryer then
        --print("Found " .. #findAll_GassFryer .. "  GassFryer Packs.")
        return findAll_GassFryer
    else
        --print("Found No GassFryer Packs")
        return nil
    end
end

local function extractID(GassFryer)
    local fullName = GassFryer:GetFullName()
    local GassFryer_ID = fullName:match("BP_GasFryer_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(GassFryer_ID))
    return GassFryer_ID
end

local function check_GassFryer_StackCount()
    local GassFryer_s = findAll_GassFryer()
    if GassFryer_s then
        for _, GassFryer in pairs(GassFryer_s) do
            local GassFryer_ID = extractID(GassFryer)
            if GassFryer_ID then
                GassFryer:SetPropertyValue("WasteOil1",0.000000)
                GassFryer:SetPropertyValue("WasteOil2",0.000000)
                GassFryer:SetPropertyValue("CleanOil1",1.000000)
                GassFryer:SetPropertyValue("CleanOil2",1.000000)
            end
        end
    end
end
LoopAsync(100, function()
    check_GassFryer_StackCount()
    return false
end)

print("Loaded OilContaminationPrevention Mod")