This script works on Lua and LuaJIT, it contains a ReadPropertyFile(file, parameters) function. 

This function return a table, every index of table is a property parameter. If you run with the next test config file:

How this works? Suppose you have the next configuration file:


```
########################################################################
#                             Example                                  #
########################################################################

msg = "Hello world!"    # This string is correct
bad1 = Hello world!"    # This string isn't between two tokens
bad2 = Hello world!     # The " token is not present

trys = 1225             # This is a numeric configuration

pi = 3.1415             # Float
e = 2.71e-4             # Cientific notation
bad3 = 12c              # The error is mix numbers and not valid text

number = 1              # If you repeat some parameter
number = 2              # the value that get is the last
number = 3              # appear in the file. In this case 3.

########################################################################
#                               End                                    #
########################################################################

```

With ReadPropertyFile(file, parameters) you can get the values from the configuration file if they exist in the table of configuration that you pass as parameter. Let's an example:


```
dofile("LuaFRPF.lua")
function Print_Table (t) 
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
print("Configuration default:")
Print_Table (config)
-- Now load the configuration from file
properties = ReadPropertyFile ("test.cnf", properties)
print("Configuration from file:")
Print_Table (config)

```

The output:

```
Configuration default:
    number  |   0
    msg     |   Hello
    trys    |   12
    pi      |   3.14
    present |   true
    e       |   0
Configuration from file:
    number  |   3
    msg     |   Hello world!
    trys    |   1225
    pi      |   3.1415
    present |   true
    e       |   0.000271
```

License in **license.txt** file.

Enjoy.
Happy Hacking!
