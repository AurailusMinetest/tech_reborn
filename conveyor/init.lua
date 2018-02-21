local nb_table = {
	[0] = {
		{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
		{-0.5, -0.4375, -0.5, -0.375, -0.3125, 0.5}, -- NodeBox2
		{0.375, -0.4375, -0.5, 0.5, -0.3125, 0.5}, -- NodeBox3
	},
	[1] = {
		{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
		{-0.5, -0.4375, -0.5, -0.375, -0.3125, 0.5}, -- NodeBox2
		{0.375, -0.4375, -0.5, 0.5, -0.3125, -0.375}, -- NodeBox3
		{0.375, -0.4375, 0.375, 0.5, -0.3125, 0.5}, -- NodeBox4}
	},
	[2] = {
		{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
		{0.5, -0.4375, -0.5, 0.375, -0.3125, 0.5}, -- NodeBox2
		{-0.375, -0.4375, -0.5, -0.5, -0.3125, -0.375}, -- NodeBox3
		{-0.375, -0.4375, 0.375, -0.5, -0.3125, 0.5}, -- NodeBox4}
	},
	[3] = {
		{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
		{0.375, -0.4375, -0.5, 0.5, -0.3125, -0.375}, -- NodeBox3
		{0.375, -0.4375, 0.375, 0.5, -0.3125, 0.5}, -- NodeBox4}
		{-0.375, -0.4375, -0.5, -0.5, -0.3125, -0.375}, -- NodeBox3
		{-0.375, -0.4375, 0.375, -0.5, -0.3125, 0.5}, -- NodeBox4}
	}
}
local names = {
	[0] = "",
	[1] = "_left",
	[2] = "_right",
	[3] = "_funnel"
}

for i = 0, 3 do
	minetest.register_node("tech_reborn:conveyor" .. names[i], {
		description = "Conveyor Belt",
		groups = {oddly_breakable_by_hand = 3, cracky = 3, choppy = 3},
		tiles = {
			{
				name = "tech_reborn_conveyor_top" .. names[i] .. ".png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
			"tech_reborn_machine.png",
			"tech_reborn_machine.png",
			"tech_reborn_machine.png",
			"tech_reborn_machine.png",
			"tech_reborn_machine.png",
		},
		drawtype = "nodebox",
		paramtype = "light",
		sunlight_propagates = true,
		node_box = {
			type = "fixed",
			fixed = nb_table[i]
		},
		paramtype2 = "facedir",
	  collision_box = {
			type = "fixed",
			fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}},
		},
	  selection_box = {
	  	type = "fixed",
	  	fixed = {{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5}},
		}
	})
end