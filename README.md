This script works on Lua and LuaJIT, it contains a Get_Config() function. The idea is get the same method of configuration like many software on Unixes with a text file.

 This function return a table, every index of table is the configuration parameter. If you run with the next test config file:

 # Example 
 trys        =  111111    # This is a numeric configuration
 pi          =  3.14 
 chain       =  "Hello world!"
 bad = Hello world!"     # This configuration is't valid. 
 bad2 = 12c              # The error is mix numbers and not valid text
 bad3 = Hello world!     # The " token is not present
 # End of example

With:

t = Get_Config ("test.cnf")
for k, v in pairs (t) do print(k, v) end

You get:

trys    111111
pi      3.14
chain   Hello world!

Enjoy.
Happy Hacking!
