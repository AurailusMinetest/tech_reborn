local path = minetest.get_modpath("tech_reborn") .. "/machines"

dofile(path .. "/monitor.lua")
dofile(path .. "/battery.lua")
dofile(path .. "/creative.lua")

minetest.register_abm({
  nodenames = {"group:machine"},
	interval = 0.1,
	chance = 1,
	action = function(pos)
   minetest.registered_nodes[minetest.get_node(pos).name].machine_update(pos)
	end,
})
