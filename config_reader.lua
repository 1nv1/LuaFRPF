
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function Get_Config (file)
    tbl_config = {}
    i = 1
    pf_config = io.open(file,'r')
    if pf_config == nil then return nil end
    for line in pf_config:lines() do
        -- Elimino los espacios en blanco
        for i = 1, #line do
            if line:sub(i,i) ~= ' ' then break end 
        end
        line = line:sub(i, #line)
        -- Reviso si es un comentario
        if line:sub(1,1) ~= '#' then
            -- Ahora separo en '='
            local cnf
            cnf = split(line, '=')
            if #cnf >= 2 then
                -- Ahora estoy completamente seguro que no hay un comentario en la primer parte
                -- Necesito revisar si hay un comentario luego de la asignación
                if cnf[2]:sub(1,1) ~= '#' then -- La asignación no es un comentario
                    local asgn 
                    asgn = split (cnf[2], '#')
                    -- Ahora almaceno
                    if #asgn <= 2 then
                        if tonumber(asgn[1]) == nil then
                            -- Puede ser un string
                            i = 1 
                            while asgn[1]:sub(i,i) == ' ' do i = i + 1 end
                            if asgn[1]:sub(i,i) == '"' then
                                if i <= #asgn[1] then
                                    asgn[1] = asgn[1]:sub(i + 1,#asgn[1])
                                end
                                i = #asgn[1]
                                while asgn[1]:sub(i,i) == ' ' do i = i - 1 end
                                if asgn[1]:sub(i,i) == '"' then                                
                                    if i+1 >= 1 then
                                        tbl_config[cnf[1]:gsub("%s+", " ")] = tostring(asgn[1]:sub(1, i-1))
                                    end
                                end
                            end
                        else 
                            -- Es un numero
                            tbl_config[cnf[1]:gsub("%s+", " ")] = tonumber(asgn[1])
                        end
                    end
                end
            end
        end
    end
    return tbl_config
end

--t = Get_Config ("test.cnf")
--for k, v in pairs (t) do print(k, v) end
