minetest.register_node("tech_reborn:tech_reborn_battery", {
    description = "Battery",
    tiles = {
	  	"tech_reborn_machine.png",
	  	"tech_reborn_machine.png",
	  	"tech_reborn_machine.png^tech_reborn_battery.png",
	  	"tech_reborn_machine.png^tech_reborn_battery.png",
	  	"tech_reborn_machine.png^tech_reborn_battery.png",
	    "tech_reborn_machine.png^tech_reborn_battery.png",
  	},
  	paramtype2 = "facedir",
    on_construct = function(pos)
      tech_reborn.wire.recalcModels(pos)
    end,
    after_destruct = function(pos)
      tech_reborn.wire.recalcModels(pos)
    end,
    groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wired_node = 1},
    sounds = default.node_sound_metal_defaults(),
    machine_update = function(pos)
      tech_reborn.pushAdjacentEnergy(pos, 50)
    end,
})
