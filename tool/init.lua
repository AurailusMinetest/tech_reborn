minetest.register_tool("tech_reborn:wrench", {
	inventory_image = "tech_reborn_wrench.png",
	tooel_capabilities = {
		full_punch_interval = 0.2,
		max_drop_level = 1,
		groupcaps = {
			snappy = {maxlevel = 1, uses = 250, times = {
				[0] = 0.1,
				[1] = 0.1,
				[2] = 0.1,
				[3] = 0.1
			}}
		}
	}
})