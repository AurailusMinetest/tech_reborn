local directions = {
	_ = {{-1, -1, -1, 1, 1, 1}},
	_ending = {{-1, -1, -1, 0.5, 1, 1}},
	_line = {{-0.5, -1, -1, 0.5, 1, 1}},
	_corner = {
		{-0.5, -1, -1, 1, 1, 1},
		{-1, -1, -0.5, 1, 1, 1}},
	_funnel = {
		{-0.5, -1, -1, 0.5, 1, 1},
		{-1, -1, -0.5, 1, 1, 1}},
	_cross = {
		{-0.5, -1, -1, 0.5, 1, 1},
		{-1, -1, -0.5, 1, 1, 0.5}}
}
local heights = {
	_ = {},
	_d = {-1, -0.5, -1, 1, 1, 1},
	_u = {-1, -1, -1, 1, 0.5, 1},
	_ud = {-1, -0.5, -1, 1, 0.5, 1}
}

function tech_reborn.register_wires(name, data)
	for insulated = 0, 1 do

		local tex = data.tex_base
		if insulated == 1 then 
			name = name .. "_insulated"
			tex = data.tex_insulated
			data.size = data.size + 2
		end

		for hname, hbox in pairs(heights) do
			for dname, dbox in pairs(directions) do

				if hname == "_" then hname = "" end
				if dname == "_" then dname = "" end

				local nodebox = table.copy(dbox)
				table.insert(nodebox, table.copy(hbox))

				local groups = {oddly_breakable_by_hand = 1, wire = 1, snappy = 3, wired_node = 1}

				if not (dname == "_line" and hname == "") then
					groups.not_in_creative_inventory = 1
				end
				
				groups[data.voltage] = 1

				local cname = name  .. dname .. hname

				--Replace 1 with width values
				for i = 1, #nodebox do
					for j = 1, #nodebox[i] do
						local val = nodebox[i][j]
						if val == 1 then val = data.size/16/2
						elseif val == -1 then val = -data.size/16/2 end
						nodebox[i][j] = val
					end 
				end

				minetest.register_node("tech_reborn:" .. cname, {
					description = data.description,
					tiles = {tex},
					groups = groups,
					sounds = default.node_sound_metal_defaults(),
					on_construct = tech_reborn.wire.constructWire,
					on_destruct = tech_reborn.wire.removeWire,
					on_rightclick = tech_reborn.wire.showOverlayOpts,
					paramtype2 = "facedir",
					drawtype = "nodebox",
					paramtype = "light",
					node_box = {
						type = "fixed",
						fixed = nodebox
					},
					node_placement_prediction = "tech_reborn:" .. name,
					drop = "tech_reborn:" .. name .. "_line",

					_base_node = "tech_reborn:" .. name,
					_base_name = "tech_reborn:" .. name,
					_voltage = data.voltage,
					_wire_size = data.size,
				})
			end

		end
	end

end

tech_reborn.register_wires("copper_wire", {
	description = "Insulated Copper Wire (LV)",
	base_node = "tech_reborn:insulated_copper_wire",
	voltage = "lv",
	tex_insulated = "tech_reborn_lv_wire.png",
	tex_base = "tech_reborn_copper_wire.png",
	damage_for_second = 0,
	size = 2
})

tech_reborn.register_wires("gold_wire", {
	description = "Insulated Gold Wire (MV)",
	base_node = "tech_reborn:insulated_gold_wire",
	voltage = "mv",
	tex_insulated = "tech_reborn_mv_wire.png",
	tex_base = "tech_reborn_gold_wire.png",
	damage_for_second = 0,
	size = 4
})

-- tech_reborn.register_wires("item_pipe", {
-- 	description = "Item Pipe",
-- 	base_node = "tech_reborn:insulated_gold_wire",
-- 	voltage = "mv",
-- 	tex_insulated = "tech_reborn_pipe.png",
-- 	tex_base = "tech_reborn_pipe.png",
-- 	damage_for_second = 0,
-- 	size = 8
-- })