function tech_reborn.getNodeCapacity(pos)
	if minetest.get_item_group(minetest.get_node(pos).name, "wire") > 0 then
		local system = minetest.get_meta(pos):get_string("sys_id")
		if not system or system == "" or not tech_reborn.wire.systems[system] then return false end

		local capacity = tech_reborn.wire.systems[system].capacity - tech_reborn.wire.systems[system].power
		return capacity
	end
end

function tech_reborn.getNodeEnergy(pos)
	if minetest.get_item_group(minetest.get_node(pos).name, "wire") > 0 then
		local system = minetest.get_meta(pos):get_string("sys_id")
		if not system or system == "" or not tech_reborn.wire.systems[system] then return false end
		return tech_reborn.wire.systems[system].power
	end
end

--Get Node Stored in adjacent Wire Nodes
function tech_reborn.getAdjacentEnergy(pos)
	local adj_nodes = tech_reborn.getAdjacent(pos)
	local total_power = 0
	local systems = {}

	for i = 1, #adj_nodes do
		if minetest.get_item_group(minetest.get_node(adj_nodes[i]).name, "wire") > 0 then
			local system = minetest.get_meta(adj_nodes[i]):get_string("sys_id")
			if not system or system == "" or not tech_reborn.wire.systems[system] then return false end

			local found = false
			for i = 1, #systems do
				if system == systems[i] then found = true; break end
			end
			if not found then
				table.insert(systems, system)
				local power = tech_reborn.getNodeEnergy(adj_nodes[i])
				if power then total_power = total_power + power end
			end
		end
	end

	return total_power
end

function tech_reborn.pushNodeEnergy(pos, amount)
	if minetest.get_item_group(minetest.get_node(pos).name, "wire") > 0 and
	minetest.get_item_group(minetest.get_node(pos).name, "import") > 0 then
		local system = minetest.get_meta(pos):get_string("sys_id")
		if not system or system == "" or not tech_reborn.wire.systems[system] then return false end

		local capacity = tech_reborn.getNodeCapacity(pos)
		if (capacity > amount) then
			tech_reborn.wire.systems[system].power = tech_reborn.wire.systems[system].power + amount
			return 0
		else
			tech_reborn.wire.systems[system].power = tech_reborn.wire.systems[system].capacity
			return amount - capacity
		end
	end
	return amount
end

function tech_reborn.pushAdjacentEnergy(pos, amount)
	local adj_nodes = tech_reborn.getAdjacent(pos)
	local systems = {}
	local count = 0
	local leftover = 0

	for i = 1, #adj_nodes do
		if not tech_reborn.getNodeCapacity(adj_nodes[i]) then
			adj_nodes[i] = false
		else
			count = count + 1
		end
	end

	for i = 1, #adj_nodes do
		if adj_nodes[i] then
			leftover = leftover + tech_reborn.pushNodeEnergy(adj_nodes[i], math.floor(amount/count))
		end
	end
	if leftover > 0 then
		for i = 1, #adj_nodes do
			if adj_nodes[i] then
				leftover = tech_reborn.pushNodeEnergy(adj_nodes[i], leftover)
			end
		end
	end
	return leftover
end

function tech_reborn.pullNodeEnergy(pos, amount)
	if minetest.get_item_group(minetest.get_node(pos).name, "wire") > 0 and
	minetest.get_item_group(minetest.get_node(pos).name, "export") > 0 then
		local system = minetest.get_meta(pos):get_string("sys_id")
		if not system or system == "" or not tech_reborn.wire.systems[system] then return false end

		local available = tech_reborn.getNodeEnergy(pos)
		if (available > amount) then
			tech_reborn.wire.systems[system].power = tech_reborn.wire.systems[system].power - amount
			return amount
		else
			tech_reborn.wire.systems[system].power = 0
			return available
		end
	end
	return 0
end

function tech_reborn.pullAdjacentEnergy(pos, amount)
	local adj_nodes = tech_reborn.getAdjacent(pos)
	local systems = {}
	local count = 0
	local got = 0

	for i = 1, #adj_nodes do
		if not tech_reborn.getNodeCapacity(adj_nodes[i]) then
			adj_nodes[i] = false
		else
			count = count + 1
		end
	end

	for i = 1, #adj_nodes do
		if adj_nodes[i] then
			got = got + tech_reborn.pullNodeEnergy(adj_nodes[i], math.floor(amount/count))
		end
	end

	if got < amount then
		for i = 1, #adj_nodes do
			if adj_nodes[i] then
				got = got + tech_reborn.pullNodeEnergy(adj_nodes[i], amount - got)
			end
		end
	end

	return got
end