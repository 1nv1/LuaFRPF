function Get_Config (file)
    local tbl_config = {}
    local i
    local cnf = {}
    local asgn = {}
    local line
    local tmp
    local pf_config = io.open(file,'r')
	-- Función local que separa en patrones un string
	local function split(str, pat)
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
    ----
    if pf_config == nil then return nil end
    -- Leo linea a línea el archivo
    for line in pf_config:lines() do
        --i = 1
        tmp = line:gsub("%s+", "")	 -- Elimino los espacios en blanco
        --print (tmp)
        -- Reviso si no es un comentario para proseguir
        if tmp:sub(1,1) ~= '#' then
            -- Ahora separo en '='
            cnf = split(line, '=')
			-- Por lo mínimo deben aparecer dos subgrupos
            if #cnf >= 2 then
                -- Eliminamos los espacios en blancos de los comentarios     
                tmp = cnf[2]:gsub("%s+", "")
                if tmp:sub(1,1) ~= '#' then -- ¿La asignación no es un comentario?
                    asgn = split (cnf[2], '#') -- Vamos a buscar los comentarios...
                    if tonumber(asgn[1]) == nil then
						-- Puede ser un string
						i = 1 
						while asgn[1]:sub(i,i) == ' ' or asgn[1]:sub(i,i) == '\t' do i = i + 1 end
						if asgn[1]:sub(i,i) == '"' then
							if i <= #asgn[1] then
								asgn[1] = asgn[1]:sub(i + 1,#asgn[1])
							end
							i = #asgn[1]
							while asgn[1]:sub(i,i) == ' ' or asgn[1]:sub(i,i) == '\t' do i = i - 1 end
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
    return tbl_config
end

function Get_Valid_Config (file, parameters)
    local tbl_config = {}
    local i
    local cnf = {}
    local asgn = {}
    local line
    local tmp
    local k, v, y, w
	local found = false
    local pf_config = io.open(file,'r')
	-- Función local que separa en patrones un string
	local function split(str, pat)
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
    ----
    if pf_config == nil then return nil end
    -- Leo linea a línea el archivo
    for line in pf_config:lines() do
        --i = 1
        tmp = line:gsub("%s+", "")	 -- Elimino los espacios en blanco
        --print (tmp)
        -- Reviso si no es un comentario para proseguir
        if tmp:sub(1,1) ~= '#' then
            -- Ahora separo en '='
            cnf = split(line, '=')
			-- Por lo mínimo deben aparecer dos subgrupos
            if #cnf >= 2 then
				cnf[1] = cnf[1]:gsub("%s+", "")
				-- Revisamos si el parámetro es válido:
				found = false
				for k,v in pairs (parameters) do
					--print(tostring(k), tostring(cnf[1]))
					if tostring(k) == tostring(cnf[1]) then 
						found = true
						break
					end
				end
				if found == true then
					-- Eliminamos los espacios en blancos de los comentarios     
					tmp = cnf[2]:gsub("%s+", "")
					if tmp:sub(1,1) ~= '#' then -- ¿La asignación no es un comentario?
						asgn = split (cnf[2], '#') -- Vamos a buscar los comentarios...
						if tonumber(asgn[1]) == nil then
							-- Puede ser un string
							i = 1 
							while asgn[1]:sub(i,i) == ' ' or asgn[1]:sub(i,i) == '\t' do i = i + 1 end
							if asgn[1]:sub(i,i) == '"' then
								if i <= #asgn[1] then
									asgn[1] = asgn[1]:sub(i + 1,#asgn[1])
								end
								i = #asgn[1]
								while asgn[1]:sub(i,i) == ' ' or asgn[1]:sub(i,i) == '\t' do i = i - 1 end
								if asgn[1]:sub(i,i) == '"' then                                
									if i+1 >= 1 then
										tbl_config[cnf[1]] = tostring(asgn[1]:sub(1, i-1))
									end
								end
							end
						else 
							-- Es un numero
							tbl_config[cnf[1]] = tonumber(asgn[1])
						end
					end
				end
            end
        end
    end
    -- Por último revisamos que parámetros no estaban y los dejamos por default
    for k, v in pairs(parameters) do
		found = false
		for w, y in pairs(tbl_config) do
			if tostring(k) == tostring(w) then
				found = true
				break
			end
		end
		if found == false then
			tbl_config[k] = parameters[k]
		end
    end
    return tbl_config
end
