--
-- SERIALIZATION FUNCTIONS
-- Turns position vector in string format, eg "10,25,-12" (x = 10, y = 25, z = -12)
--
function machinery.deserializepos(posString)
  local x = posString:sub(1, posString:find(",", 1, true) - 1)
  local y = posString:sub(x:len() + 2, posString:find(",", x:len() + 2) - 1, true)
  local z = posString:sub(y:len() + 1 + x:len() + 2, posString:find(",", x:len() + 1 + y:len() + 2), true)
  return vector.new(tonumber(x), tonumber(y), tonumber(z))
end

function machinery.serializepos(pos)
  return pos.x..","..pos.y..","..pos.z
end

--
-- GET ADJACENT
-- Return adjacent nodes
--
function machinery.getAdjacent(pos)
	return {
		vector.new(pos.x, pos.y + 1, pos.z),
		vector.new(pos.x, pos.y - 1, pos.z),
		vector.new(pos.x + 1, pos.y, pos.z),
		vector.new(pos.x - 1, pos.y, pos.z),
		vector.new(pos.x, pos.y, pos.z + 1),
		vector.new(pos.x, pos.y, pos.z - 1)
	}
end

--
-- ME Functions
-- Functions to modify energy in wires
--
function machinery.pullAdjacentME(machineNode, amount)
	local adj_nodes = machinery.getAdjacent(machineNode)
	local systems = {}

	--Find systems in adjacent nodes
	for i = 1, #adj_nodes do

	  if minetest.get_node(adj_nodes[i]).name == "machinery:wire" or
	  minetest.get_node(adj_nodes[i]).name == "machinery:wire_controller" then

	  	local system = minetest.get_meta(adj_nodes[i]):get_string("system")
		  if not system or system == "" then return false end
		  local found = false
		  for i = 1, #systems do
		  	if machinery.serializepos(systems[i]) == system then found = true end
		  end
			if not found then table.insert(systems, machinery.deserializepos(system)) end
	  end
  end
  --If system doesn't have the capacity then remove it
  for i = 1, #systems do
  	if minetest.get_meta(systems[i]):get_int("system_me") < amount then
  		table.remove(systems, i)
		end
	end
	--Pull power from system and return state
	if #systems > 0 then
		for i = 1, #systems do
			minetest.get_meta(systems[i]):set_int("system_me", minetest.get_meta(systems[i]):get_int("system_me") - amount/#systems)
		end
	end
	if amount > 0 then return amount end
	return false
end

-- function machinery.pullNodeME

function machinery.pushAdjacentME(machineNode, amount)
	local adj_nodes = machinery.getAdjacent(machineNode)
	local systems = {}

	--Find systems in adjacent nodes
	for i = 1, #adj_nodes do

	  if minetest.get_node(adj_nodes[i]).name == "machinery:wire" or
	  minetest.get_node(adj_nodes[i]).name == "machinery:wire_controller" then

	  	local system = minetest.get_meta(adj_nodes[i]):get_string("system")
		  if not system or system == "" then return false end
		  local found = false
		  for i = 1, #systems do
		  	if machinery.serializepos(systems[i]) == system then found = true end
		  end
			if not found then table.insert(systems, machinery.deserializepos(system)) end
	  end
  end
  --If system doesn't have the capacity then remove it
  for i = 1, #systems do
  	if minetest.get_meta(systems[i]):get_int("me_capacity") - minetest.get_meta(systems[i]):get_int("system_me") < amount then
  		table.remove(systems, i)
		end
	end
	--Push power from system and return state
	if #systems > 0 then
		for i = 1, #systems do
			minetest.get_meta(systems[i]):set_int("system_me", minetest.get_meta(systems[i]):get_int("system_me") + amount/#systems)
		end
	end
	if amount > 0 then return amount end
	return false
end

function machinery.checkAdjacentME(machineNode)
	local adj_nodes = machinery.getAdjacent(machineNode)
	local systems = {}

	--Find systems in adjacent nodes
	for i = 1, #adj_nodes do
	  if minetest.get_node(adj_nodes[i]).name == "machinery:wire" or
	  minetest.get_node(adj_nodes[i]).name == "machinery:wire_controller" then
	  	local system = minetest.get_meta(adj_nodes[i]):get_string("system")
		  if not system or system == "" then return false end
		  local found = false
		  for i = 1, #systems do
		  	if machinery.serializepos(systems[i]) == system then found = true end
		  end
			if not found then table.insert(systems, machinery.deserializepos(system)) end
	  end
  end
  --Calculate power
  local power = 0
  for i = 1, #systems do
  	power = power + minetest.get_meta(systems[i]):get_int("system_me")
	end
	return power
end