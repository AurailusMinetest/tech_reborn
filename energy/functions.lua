function tech_reborn.wire.wireConnectable(pos_a, pos_b)
	local def = minetest.registered_nodes[minetest.get_node(pos_b).name]
	local base_node = def._base_node
	if minetest.get_item_group(minetest.get_node(pos_a).name, "wire") > 0 then
		local def = minetest.registered_nodes[minetest.get_node(pos_a).name]
		if def._base_node == base_node then
			return true
		else
			return false
		end
	end
	return false
end

function tech_reborn.wire.removeIO(pos)
	local function get_remove(pos)
		return (minetest.get_item_group(minetest.get_node(pos).name, "wire_connect") > 0)
	end
	local function starts(String,Start)
	  return string.sub(String,1,string.len(Start)) == Start
	end

	local adjacent = tech_reborn.getAdjacent(pos)
	local dirs = {
		u = get_remove(adjacent[1]),
		d = get_remove(adjacent[2]),
		e = get_remove(adjacent[3]),
		w = get_remove(adjacent[4]),
		n = get_remove(adjacent[5]),
		s = get_remove(adjacent[6]),
	}
	
	for _,obj in pairs(minetest.get_objects_inside_radius(pos, 1.3)) do
		if obj:get_luaentity() then
			if obj:get_luaentity().basenode == tech_reborn.serializepos(pos) then
				if starts(obj:get_luaentity().name, "tech_reborn:servo_") then
					if not dirs[obj:get_luaentity().dir] then
						obj:remove()
					end
				end
			end
		end
	end

end

function tech_reborn.wire.spawnEntities(name, pos, dirs, size)
	local dmod = {
		[8] = 0.346,
		[6] = 0.374,
		[4] = 0.410,
		[2] = 0.454,
	}
	name = name .. "_"

	if dirs.u then
		local object = minetest.add_entity(pos, "tech_reborn:servo_" .. name .. size .. "_y", minetest.serialize({
			basenode = tech_reborn.serializepos(pos),
			dir = "u"
		}))
		object:setpos({x=pos.x, y=pos.y+dmod[size], z=pos.z})
	end
	if dirs.d then
		local object = minetest.add_entity(pos, "tech_reborn:servo_" .. name .. size .. "_y", minetest.serialize({
			basenode = tech_reborn.serializepos(pos),
			dir = "d"
		}))
		object:setpos({x=pos.x, y=pos.y-dmod[size], z=pos.z})
	end
	if dirs.e then
		local object = minetest.add_entity(pos, "tech_reborn:servo_" .. name .. size .. "_x", minetest.serialize({
			basenode = tech_reborn.serializepos(pos),
			dir = "e"
		}))
		object:setpos({x=pos.x+dmod[size], y=pos.y, z=pos.z})
	end
	if dirs.w then
		local object = minetest.add_entity(pos, "tech_reborn:servo_" .. name .. size .. "_x", minetest.serialize({
			basenode = tech_reborn.serializepos(pos),
			dir = "w"
		}))
		object:setpos({x=pos.x-dmod[size], y=pos.y, z=pos.z})
	end
	if dirs.n then
		local object = minetest.add_entity(pos, "tech_reborn:servo_" .. name .. size .. "_z", minetest.serialize({
			basenode = tech_reborn.serializepos(pos),
			dir = "n"
		}))
		object:setpos({x=pos.x, y=pos.y, z=pos.z+dmod[size]})
	end
	if dirs.s then
		local object = minetest.add_entity(pos, "tech_reborn:servo_" .. name .. size .. "_z", minetest.serialize({
			basenode = tech_reborn.serializepos(pos),
			dir = "s"
		}))
		object:setpos({x=pos.x, y=pos.y, z=pos.z-dmod[size]})
	end
end

function tech_reborn.wire.showOverlayOpts(pos, node, clicker, itemstack, pointed_thing)
	if clicker:get_wielded_item():get_name() == "tech_reborn:wrench" then
		local def = minetest.registered_nodes[minetest.get_node(pos).name]
		if not def then return false end
		local n = tonumber(def._wire_size)
		if not n then return false end

		local function get_connect(pos_a, pos_b)
			local def = minetest.registered_nodes[minetest.get_node(pos_b).name]
			local base_node = def._base_node
			if minetest.get_item_group(minetest.get_node(pos_a).name, "wire_connect") > 0 then
				return true
			end
			return false
		end

		local adjacent = tech_reborn.getAdjacent(pos)
		local dirs = {
			u = get_connect(adjacent[1], pos),
			d = get_connect(adjacent[2], pos),
			e = get_connect(adjacent[3], pos),
			w = get_connect(adjacent[4], pos),
			n = get_connect(adjacent[5], pos),
			s = get_connect(adjacent[6], pos),
		}

		tech_reborn.wire.spawnEntities("preview", pos, dirs, n)
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
		local altChildcount = tech_reborn.wire.systems[oldSys].childcount
		local altPower = tech_reborn.wire.systems[oldSys].power
		tech_reborn.wire.systems[newSys].power = tech_reborn.wire.systems[newSys].power + altPower
		tech_reborn.wire.systems[newSys].childcount = tech_reborn.wire.systems[newSys].childcount + altChildcount
		tech_reborn.wire.systems[newSys].capacity = tech_reborn.wire.systems[newSys].childcount * 50

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
		if tech_reborn.wire.wireConnectable(pos, node) then
			local id = minetest.get_meta(node):get_string("sys_id")
			if id and id ~= "" then
				if not found then
					minetest.get_meta(pos):set_string("sys_id", id)
					tech_reborn.wire.systems[id].children[tech_reborn.serializepos(pos)] = true
					tech_reborn.wire.systems[id].childcount = tech_reborn.wire.systems[id].childcount + 1
					tech_reborn.wire.systems[id].capacity = tech_reborn.wire.systems[id].childcount * 50
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
		childcount = 1,
		children = {},
		power = 0,
		capacity = 50
	}
	tech_reborn.wire.systems[id].children[tech_reborn.serializepos(pos)] = true
	tech_reborn.wire.save_systems()
	return true
end

function tech_reborn.wire.removeWire(pos)
	local function starts(String,Start)
	  return string.sub(String,1,string.len(Start)) == Start
	end

	--Remove Entities
	for _,obj in pairs(minetest.get_objects_inside_radius(pos, 1.3)) do
		if obj:get_luaentity() then
			if obj:get_luaentity().basenode == tech_reborn.serializepos(pos) then
				if starts(obj:get_luaentity().name, "tech_reborn:servo_") then
					obj:remove()
				end
			end
		end
	end

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