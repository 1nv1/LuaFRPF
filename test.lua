dofile("LuaFRPF.lua")
function PrintProperties (t) 
    for k, v in pairs (t) do print("\t"..tostring(k).."\t|\t"..tostring(v)) end
end
-- Load default value table
properties = {
        msg = "Hello",
        trys = 12,
        pi = 3.14,
        e = 0,-- The e parameter is not define
        number = 0,
        present = true
}
print("Properties default:")
PrintProperties (properties)
-- Now load the configuration from file
properties = ReadPropertiesFile ("test.cnf", properties)
print("Properties from file:")
PrintProperties (properties)
