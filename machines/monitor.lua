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
    groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wire_connect = 1},
    sounds = default.node_sound_metal_defaults(),
    on_timer = function(pos)
      local power = tech_reborn.getAdjacentEnergy(pos)
      local capacity = tech_reborn.getAdjacentMaxCapacity(pos)
      if power == false then power = 0 end
      minetest.get_meta(pos):set_string("infotext", "System Power: " .. power .. " ME / " .. capacity .. " ME")
      return true
    end,
    on_construct = function(pos)
      local timer = minetest.get_node_timer(pos)
      if timer and not timer:is_started() then
        timer:start(0.1)
      end
    end,
})