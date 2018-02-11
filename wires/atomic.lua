machinery.wire.systems = {}
machinery.wire.systemfile = minetest.get_worldpath() .. "/machinery_systems.mt"

local input = io.open(machinery.wire.systemfile, "r")
local filedata = nil
if input then
	filedata = input:read('*all')
end
if filedata and filedata ~= "" then
	machinery.wire.systems = minetest.deserialize(filedata)
	io.close(input)
end

function machinery.wire.save_systems()
	local output = io.open(machinery.wire.systemfile, "w")
	output:write(minetest.serialize(machinery.wire.systems))
	io.close(output)
end

local function save_loop()
	machinery.wire.save_systems()
	minetest.after(2, save_loop)
end
minetest.after(0, save_loop)

minetest.register_on_shutdown(function()
	machinery.wire.save_systems()
end)