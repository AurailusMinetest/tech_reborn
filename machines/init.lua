local path = minetest.get_modpath("machinery") .. "/machines"

dofile(path .. "/monitor.lua")
dofile(path .. "/battery.lua")

minetest.register_abm({
  nodenames = {"group:machine"},
	interval = 0.5,
	chance = 1,
	action = function(pos)
   minetest.registered_nodes[minetest.get_node(pos).name].machinery_update(pos)
	end,
})
