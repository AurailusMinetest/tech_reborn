minetest.register_node("tech_reborn:machine_monitor", {
    description = "Monitor",
    tiles = {
	  	"tech_reborn_machine.png",
	  	"tech_reborn_machine.png",
	  	"tech_reborn_machine.png",
	  	"tech_reborn_machine.png",
	  	"tech_reborn_machine.png",
	    "tech_reborn_machine.png^tech_reborn_monitor.png",
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
      local power = tech_reborn.getAdjacentEnergy(pos)
      if power == false then power = 0 end
      minetest.get_meta(pos):set_string("infotext", "System Power: " .. power .. " ME")
    end,
})
