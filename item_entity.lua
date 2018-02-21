local builtin_item = minetest.registered_entities["__builtin:item"]

local item = {
	set_item = function(self, itemstring)
		builtin_item.set_item(self, itemstring)
	end,
	on_step = function(self, dtime)
		builtin_item.on_step(self, dtime)

		local node = minetest.get_node_or_nil(self.object:getpos())
		if not node then
			return
		end

		if node.name == "tech_reborn:conveyor" then
			function round(x)
				return math.floor(x + 0.5)
			end
			
			local spd = 0.03
			local ops = {
				[0] = {x = 0, y = 0, z = spd},
				[1] = {x = spd, y = 0, z = 0},
				[2] = {x = 0, y = 0, z = -spd},
				[3] = {x = -spd, y = 0, z = 0},
			}

			local pos = self.object:getpos()

			if node.param2 == 0 or node.param2 == 2 then
				pos.x = round(pos.x)
			end
			if node.param2 == 1 or node.param2 == 3 then
				pos.z = round(pos.z)
			end

			pos = vector.add(pos, (ops[node.param2] or {x = 0, y = 0, z = 0}))

			self.object:setpos(pos)
		end
	end
}
setmetatable(item, builtin_item)
minetest.register_entity(":__builtin:item", item)