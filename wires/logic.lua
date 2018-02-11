function machinery.wire.constructWire(pos)
	local update = machinery.getAdjacent(pos)
	table.insert(update, pos)
	for i = 1, #update do
		if minetest.get_item_group(minetest.get_node(update[i]).name, "wire") > 0 then
			machinery.wire.setModel(update[i])
		end
	end

	machinery.wire.createWire(pos)
end

function machinery.wire.consumeSystem(newSys, oldSys)
	if newSys and newSys ~= "" and oldSys and oldSys ~= "" and
	machinery.wire.systems[newSys] ~= nil and machinery.wire.systems[oldSys] ~= nil then
		local children = machinery.wire.systems[oldSys].children
		machinery.wire.systems[oldSys] = nil

		for spos,_ in pairs(children) do
			pos = machinery.deserializepos(spos)
			machinery.wire.systems[newSys].children[spos] = true
			minetest.get_meta(pos):set_string("sys_id", newSys)
		end

		machinery.wire.save_systems()
		return true
	end
	return false
end

function machinery.wire.createWire(pos)
	--Check Adjacent Nodes
	local adjacent = machinery.getAdjacent(pos)
	local found = false
	for i = 1, #adjacent do
		local node = adjacent[i]
		if minetest.get_item_group(minetest.get_node(node).name, "wire") > 0 then
			local id = minetest.get_meta(node):get_string("sys_id")
			if id and id ~= "" then
				if not found then
					print("the id that I JUST FOUND is " .. id)
					minetest.get_meta(pos):set_string("sys_id", id)
					machinery.wire.systems[id].children[machinery.serializepos(pos)] = true
					machinery.wire.save_systems()
					found = id
				else 
					if id ~= found then
						machinery.wire.consumeSystem(found, id)
					end
				end
			end
		end
	end
	if found then return true end

	--No Adjacent Nodes to Pair to
	local id = tostring(minetest.get_us_time())
	minetest.get_meta(pos):set_string("sys_id", id)
	machinery.wire.systems[id] = {
		id = id,
		children = {},
		power = 0
	}
	machinery.wire.systems[id].children[machinery.serializepos(pos)] = true
	machinery.wire.save_systems()
	return true
end

function machinery.wire.removeWire(pos)
	local id = minetest.get_meta(pos):get_string("sys_id")

	minetest.after(0, function(pos, id)

		local update = machinery.getAdjacent(pos)
		for i = 1, #update do
			if minetest.get_item_group(minetest.get_node(update[i]).name, "wire") > 0 then
				machinery.wire.setModel(update[i])
			end
		end

		if id and id ~= "" then
			if machinery.wire.systems[id] ~= nil then
				
				local children = machinery.wire.systems[id].children
				children[machinery.serializepos(pos)] = nil

				machinery.wire.systems[id] = nil

				for spos,_ in pairs(children) do
					pos = machinery.deserializepos(spos)
					minetest.get_meta(pos):set_string("sys_id", "")
				end

				for spos,_ in pairs(children) do
					pos = machinery.deserializepos(spos)
					machinery.wire.createWire(pos)
				end

				machinery.wire.save_systems()
			end
		end
	end, pos, id)
end