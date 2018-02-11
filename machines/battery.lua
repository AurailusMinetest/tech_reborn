minetest.register_node("machinery:machinery_battery", {
    description = "Battery",
    tiles = {
	  	"machinery_machine.png",
	  	"machinery_machine.png",
	  	"machinery_machine.png^machinery_battery.png",
	  	"machinery_machine.png^machinery_battery.png",
	  	"machinery_machine.png^machinery_battery.png",
	    "machinery_machine.png^machinery_battery.png",
  	},
  	paramtype2 = "facedir",
    is_ground_content = true,
    groups = {dig_immediate = 3, oddly_breakable_by_hand = 1, machine = 1},
    sounds = default.node_sound_metal_defaults(),
    machinery_update = function(pos)
      machinery.pushAdjacentME(pos, 50)
    end,
})
