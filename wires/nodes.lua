function machinery.register_wire(name, description)
	--Inventory Node
	minetest.register_node(name, {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.125, -0.125, 0.125, 0.125, 0.125},
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_end", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_line", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_1", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_2", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.125, 0.125, 0.125, 0.5}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_funnel", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_cross", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.5, 0.125, 0.125, 0.5}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_end_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_line_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_1_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_2_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.125, 0.125, 0.125, 0.5}, -- NodeBox2
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_funnel_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_cross_d", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.5, 0.125, 0.125, 0.5}, -- NodeBox2
				{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_end_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_line_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_1_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
			{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_2_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.125, 0.125, 0.125, 0.5}, -- NodeBox2
			{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_funnel_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
			{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_cross_u", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.5, 0.125, 0.125, 0.5}, -- NodeBox2
			{-0.125, -0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_end_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.125, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
				{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_line_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox2
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_1_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_corner_2_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.125, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.125, 0.125, 0.125, 0.5}, -- NodeBox2
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_funnel_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.5, 0.125, 0.125, 0.125}, -- NodeBox2
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})

	minetest.register_node(name .. "_cross_ud", {
		description = description,
		tiles = {"machinery_wire.png"},
		is_ground_content = false,
		groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, wire = 1},
		sounds = default.node_sound_metal_defaults(),
		on_construct = machinery.wire.constructWire,
		on_destruct = machinery.wire.removeWire,
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
			{-0.5, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox1
			{-0.125, -0.125, -0.5, 0.125, 0.125, 0.5}, -- NodeBox2
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox3
			}
		},
		drop = name
	})
end

machinery.register_wire("machinery:wire", "Wire")