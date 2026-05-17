
-- Function to find all customer components dynamically
local function findAllCustomers()
    local allCustomers = FindAllOf("BP_Customer_C") -- Get all instances of BP_Customer_C
    if allCustomers then
        --print("Found " .. #allCustomers .. " customers.")
        return allCustomers
    else
        --print("No customers found.")
        return nil
    end
end

local function extractID(Customer)
    local fullName = Customer:GetFullName()
    local Customer_ID = fullName:match("BP_Customer_C_([%d]+)$")
    --print("Extracted Bun Pack ID: " .. tostring(Customer_ID))
    return Customer_ID
end

-- Function to set the patience for all customers
local function setAllCustomersPatience(value)
    local customers = findAllCustomers()
    if customers then
        for _, customer in pairs(customers) do
            local Customer_ID = extractID(customer)
            if Customer_ID and customer:GetPropertyValue("PatienceSpeed") >0 then
                customer:SetPropertyValue("UpdatePatienceTime",0.0)
                customer:SetPropertyValue("Patience", value)
                customer:SetPropertyValue("PatienceSpeed",0.0)
                --print("Set Patience to " .. value .. " for customer: " .. customer:GetFullName())
                --print("Set UpdatePatienceTime to " .. 0.0 .. " for customer: " .. customer:GetFullName())
                --print("Set PatienceSpeed to " .. 0.0 .. " for customer: " .. customer:GetFullName())
            end
        end
    end
end
-- Function to toggle the patience mod on/off
local function togglePatienceMod()
        -- Start the LoopAsync to keep setting patience every 100ms
        LoopAsync(10000, function()
                setAllCustomersPatience(1.0) -- Continuously set patience to 1.0
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
            print("Game Difficulty Is Set To Easy! Bypassing CustomerPatience")
        else
            print("Loaded CustomerPatience Mod- Thanks b3ck")
            print("Running CustomerPatience Mod")
            print("Game Difficulty is set to: " .. mode)
            togglePatienceMod()
        end
    else
        print("Did not locate BP_BakeryGameInstance_C_")
    end