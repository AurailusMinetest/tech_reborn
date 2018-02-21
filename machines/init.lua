local path = minetest.get_modpath("tech_reborn") .. "/machines"

dofile(path .. "/monitor.lua")
dofile(path .. "/battery.lua")
dofile(path .. "/creative.lua")

minetest.register_lbm({
  label = "Start Machine Timers",
  name = "tech_reborn:start_timers",
  nodenames = {"group:machine"},
  run_at_every_load = true,
	action = function(pos, node)
    local timer = minetest.get_node_timer(pos)
    if timer and not timer:is_started() then
      timer:start(0.1)
    end
	end,
})

minetest.register_on_placenode(function(pos, node)
  if minetest.get_item_group(minetest.get_node(pos).name, "machine") > 0 then
    tech_reborn.wire.recalcModels(pos)
  end
end)

minetest.register_on_dignode(function(pos, node)
  if minetest.get_item_group(node.name, "machine") > 0 then
    minetest.after(0, function(pos) tech_reborn.wire.recalcModels(pos) end, pos)
  end
end)