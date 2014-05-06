----------------------------------------
dofile("config_reader.lua")
function Print_Table (t) 
	for k, v in pairs (t) do print("\t"..tostring(k).."\t|\t"..tostring(v)) end
end
-- Load default value table
config = {
		msg = "Hello",
		trys = 12,
		pi = 3.14,
		e = 0,-- The e parameter is not define
		number = 0,
		present = true
}
print("Configuration default:")
Print_Table (config)
-- Now load the configuration from file
config = Get_Valid_Config ("test.cnf", config)
print("Configuration from file:")
Print_Table (config)
