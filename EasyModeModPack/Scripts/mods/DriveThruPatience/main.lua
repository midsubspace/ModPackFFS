
-- Function to find all customer components dynamically
local function findAllDriveThruCustomers()
    local allDriveThruCustomers = FindAllOf("BP_DriveThruCar_C") -- Get all instances of BP_DriveThruCar_C
    if allDriveThruCustomers then
        --print("Found " .. #allDriveThruCustomers .. " DriveThruCustomers.")
        return allDriveThruCustomers
    else
        --print("No DriveThruCustomers found.")
        return nil
    end
end

-- Function to set the patience for all DriveThruCustomers
local function setAllDriveThruCustomersPatience(value)
    local DriveThruCustomers = findAllDriveThruCustomers()
    if DriveThruCustomers then
        for _, customer in pairs(DriveThruCustomers) do
            customer:SetPropertyValue("Patience", value)
            
            --print("Set Patience to " .. value .. " for customer: " .. customer:GetFullName())
        end
    end
end
-- Function to toggle the patience mod on/off
local function togglePatienceMod()
        -- Start the LoopAsync to keep setting patience every 100ms
        LoopAsync(10000, function()
                setAllDriveThruCustomersPatience(1.0) -- Continuously set patience to 1.0
        end)
end
    local mode
    local GameSetting = FindAllOf("BP_BakeryGameInstance_C")
    if GameSetting then
        print("Found Game Settings")
        for _, GameDifficulty in pairs(GameSetting) do
             mode = GameDifficulty:GetPropertyValue("GameDifficulty",field)
             break
        end 
        if mode == 0 then
            print("Game Difficulty Is Set To Easy! Bypassing DriveThruPatience")
        else
            print("Loaded DriveThruPatience Mod- Thanks b3ck")
            print("Running DriveThruPatience Mod")
            print("Game Difficulty is set to: " .. mode)
            togglePatienceMod()
        end
    else
        print("Did not locate BP_BakeryGameInstance_C_")
    end