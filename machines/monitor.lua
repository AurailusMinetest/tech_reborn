minetest.register_node("machinery:machine_monitor", {
    description = "Monitor",
    tiles = {
	  	"machinery_machine.png",
	  	"machinery_machine.png",
	  	"machinery_machine.png",
	  	"machinery_machine.png",
	  	"machinery_machine.png",
	    "machinery_machine.png^machinery_monitor.png",
  	},
  	paramtype2 = "facedir",
    is_ground_content = true,
    groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, machine = 1},
    sounds = default.node_sound_metal_defaults(),
    machinery_update = function(pos)
      local power = machinery.checkAdjacentME(pos)
      if power == false then power = 0 end
      minetest.get_meta(pos):set_string("infotext", "System Power: " .. power .. " ME")
    end,
})
