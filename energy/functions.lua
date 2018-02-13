function tech_reborn.wire.changeState(pos, node, clicker, itemstack, pointed_thing)
	if clicker:get_wielded_item():get_name() == "tech_reborn:wrench" then
		local def = minetest.registered_nodes[minetest.get_node(pos).name]
		if not def then return false end

		local estate = def._export_state
		if estate == "none" then mstring = "_import"
		elseif estate == "import" then mstring = "_export"
		elseif estate == "export" then mstring = "" end

		minetest.swap_node(pos, {name = def._base_node .. mstring})
		tech_reborn.wire.recalcModels(pos)
	else
		minetest.item_place_node(itemstack, clicker, pointed_thing)
	end
end

function tech_reborn.wire.constructWire(pos)
	tech_reborn.wire.recalcModels(pos)
	tech_reborn.wire.createWire(pos)
end

function tech_reborn.wire.consumeSystem(newSys, oldSys)
	if newSys and newSys ~= "" and oldSys and oldSys ~= "" and
	tech_reborn.wire.systems[newSys] ~= nil and tech_reborn.wire.systems[oldSys] ~= nil then
		local children = tech_reborn.wire.systems[oldSys].children
		local altPower = tech_reborn.wire.systems[oldSys].power
		tech_reborn.wire.systems[newSys].power = tech_reborn.wire.systems[newSys].power + altPower

		tech_reborn.wire.systems[oldSys] = nil

		for spos,_ in pairs(children) do
			pos = tech_reborn.deserializepos(spos)
			tech_reborn.wire.systems[newSys].children[spos] = true
			minetest.get_meta(pos):set_string("sys_id", newSys)
		end

		tech_reborn.wire.save_systems()
		return true
	end
	return false
end

function tech_reborn.wire.createWire(pos)
	--Check Adjacent Nodes
	local adjacent = tech_reborn.getAdjacent(pos)
	local found = false
	for i = 1, #adjacent do
		local node = adjacent[i]
		if minetest.get_item_group(minetest.get_node(node).name, "wire") > 0 then
			local id = minetest.get_meta(node):get_string("sys_id")
			if id and id ~= "" then
				if not found then
					minetest.get_meta(pos):set_string("sys_id", id)
					tech_reborn.wire.systems[id].children[tech_reborn.serializepos(pos)] = true
					tech_reborn.wire.save_systems()
					found = id
				else 
					if id ~= found then
						tech_reborn.wire.consumeSystem(found, id)
					end
				end
			end
		end
	end
	if found then return true end

	--No Adjacent Nodes to Pair to
	local id = tostring(minetest.get_us_time())
	minetest.get_meta(pos):set_string("sys_id", id)
	tech_reborn.wire.systems[id] = {
		id = id,
		children = {},
		power = 0,
		capacity = 1000
	}
	tech_reborn.wire.systems[id].children[tech_reborn.serializepos(pos)] = true
	tech_reborn.wire.save_systems()
	return true
end

function tech_reborn.wire.removeWire(pos)
	local id = minetest.get_meta(pos):get_string("sys_id")

	minetest.after(0, function(pos, id)
		tech_reborn.wire.recalcModels(pos)

		if id and id ~= "" then
			if tech_reborn.wire.systems[id] ~= nil then
				local power = tech_reborn.wire.systems[id].power
				
				local children = tech_reborn.wire.systems[id].children
				children[tech_reborn.serializepos(pos)] = nil

				tech_reborn.wire.systems[id] = nil

				for spos,_ in pairs(children) do
					spos = tech_reborn.deserializepos(spos)
					minetest.get_meta(spos):set_string("sys_id", "")
				end

				for spos,_ in pairs(children) do
					spos = tech_reborn.deserializepos(spos)
					tech_reborn.wire.createWire(spos)
				end

				local split = 0
				local adjacent = tech_reborn.getAdjacent(pos)
				for i = 1, #adjacent do
					if minetest.get_item_group(minetest.get_node(adjacent[i]).name, "wire") <= 0 then
						adjacent[i] = false
					else
						split = split + 1
					end
				end
				power = math.floor(power / split)
				for i = 1, #adjacent do
					if adjacent[i] then
						tech_reborn.wire.systems[minetest.get_meta(adjacent[i]):get_string("sys_id")].power = 
							tech_reborn.wire.systems[minetest.get_meta(adjacent[i]):get_string("sys_id")].power + power
					end
				end

				tech_reborn.wire.save_systems()
			end
		end
	end, pos, id)
end