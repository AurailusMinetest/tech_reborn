tech_reborn.wire.systems = {}
tech_reborn.wire.systemfile = minetest.get_worldpath() .. "/tech_reborn_systems.mt"

local input = io.open(tech_reborn.wire.systemfile, "r")
local filedata = nil
if input then
	filedata = input:read('*all')
end
if filedata and filedata ~= "" then
	tech_reborn.wire.systems = minetest.deserialize(filedata)
	io.close(input)
end

function tech_reborn.wire.save_systems()
	local output = io.open(tech_reborn.wire.systemfile, "w")
	output:write(minetest.serialize(tech_reborn.wire.systems))
	io.close(output)
end

local function save_loop()
	tech_reborn.wire.save_systems()
	minetest.after(2, save_loop)
end
minetest.after(0, save_loop)

minetest.register_on_shutdown(function()
	tech_reborn.wire.save_systems()
end)