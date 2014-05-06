----------------------------------------
dofile("config_reader.lua")
function Print_Table (t) 
	for k, v in pairs (t) do print(k, v) end
end
-- Load default value table
config = {
		msg = "Hello",
		trys = 12,
		pi = 3.14,
		--e = 0,-- The e parameter is not define
		number = 0
}

--print("Print the default values:")
--Print_Table (config)

-- Now load the configuration from file
local tbl = {}
tbl = Get_Config ("test.cnf")
-- Now, ¿Is
local k, v
for k, v in pairs (config) do
	if tbl[k] ~= nil then
		config[k] = tbl[k]
	end
end
print("Configuration from file:")
--Print_Table (tbl)
--Print_Table (config)
----------------------------------------
