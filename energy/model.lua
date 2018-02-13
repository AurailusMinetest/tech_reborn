function tech_reborn.wire.recalcModels(pos)
	local update = tech_reborn.getAdjacent(pos)
	table.insert(update, pos)
	for i = 1, #update do
		if minetest.get_item_group(minetest.get_node(update[i]).name, "wire") > 0 then
			tech_reborn.wire.setModel(update[i])
		end
	end
end

function tech_reborn.wire.setModel(pos)
	local wires = {}
	local adjacent = tech_reborn.getAdjacent(pos)

	local def = minetest.registered_nodes[minetest.get_node(pos).name]
	if not def then return false end

	base = def._base_name
	if not base then return false end
	
	for i = 3, #adjacent do
		if minetest.get_item_group(minetest.get_node(adjacent[i]).name, "wired_node") > 0 then
			wires[i - 2] = true
		else wires[i - 2] = false end
	end

	local suffix = ""
	if minetest.get_item_group(minetest.get_node(adjacent[1]).name, "wired_node") > 0 then
		if minetest.get_item_group(minetest.get_node(adjacent[2]).name, "wired_node") > 0 then
			suffix = "_ud"
		else suffix = "_u" end
	elseif minetest.get_item_group(minetest.get_node(adjacent[2]).name, "wired_node") > 0 then
		suffix = "_d"
	end

	if dump(wires) == dump({false, false, false, false}) then --Dot

		minetest.swap_node(pos, {name = base .. suffix})

	elseif dump(wires) == dump({true, true, false, false}) then --Line A

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = base .. "_line" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, false, true, true}) then --Line B

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_line" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, true, true, true}) then --Cross

		minetest.swap_node(pos, {name = base .. "_cross" .. suffix})

	elseif dump(wires) == dump({true, true, true, false}) then --Funnel Z-

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, -1))
		minetest.swap_node(pos, {name = base .. "_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, true, false, true}) then --Funnel Z+

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = base .. "_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, true, true}) then --Funnel X-

		local facedir = minetest.dir_to_facedir(vector.new(-1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, true, true, true}) then --Funnel X+

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, false, false}) then --End X+

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = base .. "_ending" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, true, false, false}) then --End X-

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, -1))
		minetest.swap_node(pos, {name = base .. "_ending" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, false, true, false}) then --End Z+

		local facedir = minetest.dir_to_facedir(vector.new(-1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_ending" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, false, false, true}) then --End Z-

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_ending" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, true, false}) then --Corner 1

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, -1))
		minetest.swap_node(pos, {name = base .. "_corner" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, false, true}) then --Corner 2
		local facedir = minetest.dir_to_facedir(vector.new(-1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_corner" .. suffix, param2 = facedir})
	elseif dump(wires) == dump({false, true, true, false}) then --Corner 3
		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = base .. "_corner" .. suffix, param2 = facedir})
	elseif dump(wires) == dump({false, true, false, true}) then --Corner 4
		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = base .. "_corner" .. suffix, param2 = facedir})
	end
end