tech_reborn.wire = {};

local path = minetest.get_modpath("tech_reborn") .. "/energy"
dofile(path .. "/model.lua")
dofile(path .. "/file.lua")
dofile(path .. "/functions.lua")
dofile(path .. "/energy-transfer.lua")
dofile(path .. "/nodes.lua")

--DEBUG--
--Disable in production
-- minetest.register_abm({
--   label = "DEBUG - Wires",
-- 	nodenames = {"group:wire"},
-- 	interval = 0.2,
-- 	chance = 1,
-- 	action = function(pos)
-- 		minetest.get_meta(pos):set_string("infotext", minetest.get_meta(pos):get_string("sys_id"))
-- 	end,
-- })