function machinery.wire.setModel(pos)
	local wires = {}
	local adjacent = machinery.getAdjacent(pos)
	for i = 3, #adjacent do
		if minetest.get_item_group(minetest.get_node(adjacent[i]).name, "wire") > 0 then
			wires[i - 2] = true
		else wires[i - 2] = false end
	end

	local suffix = ""
	if minetest.get_item_group(minetest.get_node(adjacent[1]).name, "wire") > 0 then
		if minetest.get_item_group(minetest.get_node(adjacent[2]).name, "wire") > 0 then
			suffix = "_ud"
		else suffix = "_u" end
	elseif minetest.get_item_group(minetest.get_node(adjacent[2]).name, "wire") > 0 then
		suffix = "_d"
	end

	print(suffix)

	if dump(wires) == dump({false, false, false, false}) then --Dot

		minetest.swap_node(pos, {name = "machinery:wire" .. suffix})

	elseif dump(wires) == dump({true, true, false, false}) then --Line A

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = "machinery:wire_line" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, false, true, true}) then --Line B

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_line" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, true, true, true}) then --Cross

		minetest.swap_node(pos, {name = "machinery:wire_cross" .. suffix})

	elseif dump(wires) == dump({true, true, true, false}) then --Funnel Z-

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, -1))
		minetest.swap_node(pos, {name = "machinery:wire_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, true, false, true}) then --Funnel Z+

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = "machinery:wire_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, true, true}) then --Funnel X-

		local facedir = minetest.dir_to_facedir(vector.new(-1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, true, true, true}) then --Funnel X+

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_funnel" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, false, false}) then --End X+

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = "machinery:wire_end" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, true, false, false}) then --End X-

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, -1))
		minetest.swap_node(pos, {name = "machinery:wire_end" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, false, true, false}) then --End Z+

		local facedir = minetest.dir_to_facedir(vector.new(-1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_end" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, false, false, true}) then --End Z-

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_end" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, true, false}) then --Corner 1

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, -1))
		minetest.swap_node(pos, {name = "machinery:wire_corner_1" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({true, false, false, true}) then --Corner 2

		local facedir = minetest.dir_to_facedir(vector.new(-1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_corner_1" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, true, true, false}) then --Corner 3

		local facedir = minetest.dir_to_facedir(vector.new(1, 0, 0))
		minetest.swap_node(pos, {name = "machinery:wire_corner_1" .. suffix, param2 = facedir})

	elseif dump(wires) == dump({false, true, false, true}) then --Corner 4

		local facedir = minetest.dir_to_facedir(vector.new(0, 0, 1))
		minetest.swap_node(pos, {name = "machinery:wire_corner_1" .. suffix, param2 = facedir})

	end
end