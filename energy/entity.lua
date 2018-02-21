local scale = 0.25
local punchtimes = 3
local wmod = {
	[8] = 0.62,
	[6] = 0.69,
	[4] = 0.70,
	[2] = 1.00,
}

local function activate_preview(self, staticdata)
 	self.object:set_armor_groups({immortal = 1})
 	local data = minetest.deserialize(staticdata)
 	if not data then 
 		self.object:remove()
 		return
	end
	self.dir = data.dir
 	self.basenode = data.basenode
 	self.time = 0
end

local function destroy_preview(self)
	local pos = self.object:get_pos()

	local function starts(String,Start)
	  return string.sub(String,1,string.len(Start)) == Start
	end

	for _,obj in pairs(minetest.get_objects_inside_radius(pos, 1.3)) do
		if obj:get_luaentity() then
			if obj:get_luaentity().basenode == self.basenode then
				if starts(obj:get_luaentity().name, "tech_reborn:servo_preview") then
					obj:remove()
				end
			end
		end
	end

end

local function rightclick_preview(self, clicker)
	destroy_preview(self)
	local def = minetest.registered_nodes[minetest.get_node(tech_reborn.deserializepos(self.basenode)).name]
	if not def then return false end
	local n = tonumber(def._wire_size)
	if not n then return false end
	tech_reborn.wire.spawnEntities("import", tech_reborn.deserializepos(self.basenode), {[self.dir] = true}, n + 2)
end

local function step_preview(self, dtime)
	self.time = self.time + dtime
	if self.time > 4 then
		self.object:remove()
		return
	end
end

local function activate_servo(self, staticdata)
 	self.object:set_armor_groups({immortal = 1})
 	local data = minetest.deserialize(staticdata)
 	if not data then 
 		self.object:remove()
 		return
	end
	self.dir = data.dir
 	self.basenode = data.basenode
 	if not self.io then
 		self.io = data.io
	end

	tech_reborn.setIO(tech_reborn.deserializepos(self.basenode), {[self.dir] = self.io})
end

local function destroy_servo(self, puncher, time_from_last_punch)
	if puncher:get_wielded_item():get_name() == "tech_reborn:wrench" then
		local hp = self.object:get_hp() - 1
		if time_from_last_punch > 1 then
			hp = punchtimes
		end
		if hp <= 0 then
			tech_reborn.setIO(tech_reborn.deserializepos(self.basenode), {[self.dir] = false})
		end
		self.object:set_hp(hp)
	end
end

local function rightclick_servo(self, clicker)
	if clicker:get_wielded_item():get_name() == "tech_reborn:wrench" then
		self.object:remove()

		local def = minetest.registered_nodes[minetest.get_node(tech_reborn.deserializepos(self.basenode)).name]
		if not def then return false end
		local n = tonumber(def._wire_size)
		if not n then return false end

		local theoldswitcheroo = {
			import = "export",
			export = "import",
		}

		tech_reborn.wire.spawnEntities(theoldswitcheroo[self.io], tech_reborn.deserializepos(self.basenode), {[self.dir] = true}, n+2)
	end
end

local function static_servo(self)
	return minetest.serialize({
		dir = self.dir,
		basenode = self.basenode,
		io = self.io,
	})
end

base_table = {
  physical = false,
  visual = "mesh",
  visual_size = {x=2.55, y=2.55},
  is_visible = true,
  makes_footstep_sound = false,
  automatic_rotate = false,
}
servo_table = {
	hp_max = punchtimes,
  on_rightclick = rightclick_servo,
  on_punch = destroy_servo,
  get_staticdata = static_servo
}
preview_table = {
	hp_max = 1,
  textures = {"tech_reborn_servo_preview.png"},
  on_rightclick = rightclick_preview,
  on_step = step_preview,
  on_punch = destroy_preview,
}

for n = 4, 8, 2 do
	--
	-- Servo Initialization
	--
	local scale = 0.255 * (n / 8)
	local table

	for i = 0, 1 do
		local s = "import"
		if i == 1 then s = "export" end

		table = {
		  collisionbox = {-scale, -(scale * wmod[n]), -scale, scale, (scale * wmod[n]), scale},
		  mesh = "tech_reborn_servo_top_" .. n .. ".x",
		  textures = {"tech_reborn_servo_" .. s .. "_" .. n .. ".png^tech_reborn_servo_overlay_" .. n .. ".png"},
		  on_activate = function(self, staticdata) 
		  	self.io = s
		  	activate_servo(self, staticdata)
		  end,
		}
		for k,v in pairs(base_table) do table[k] = v end
		for k,v in pairs(servo_table) do table[k] = v end
		minetest.register_entity("tech_reborn:servo_" .. s .. "_" .. n .. "_y", table)

		table = {
		  collisionbox = {-(scale * wmod[n]), -scale, -scale, (scale * wmod[n]), scale, scale},
		  mesh = "tech_reborn_servo_side_" .. n .. ".x",
		  textures = {"tech_reborn_servo_" .. s .. "_" .. n .. ".png^tech_reborn_servo_overlay_" .. n .. ".png"},
		  on_activate = function(self, staticdata) 
		  	self.io = s
		  	activate_servo(self, staticdata)
		  end,
		}
		for k,v in pairs(base_table) do table[k] = v end
		for k,v in pairs(servo_table) do table[k] = v end
		minetest.register_entity("tech_reborn:servo_" .. s .. "_" .. n .. "_x", table)

		table = {
		  collisionbox = {-scale, -scale, -(scale * wmod[n]), scale, scale, (scale * wmod[n])},
		  mesh = "tech_reborn_servo_side_" .. n .. ".x",
		  textures = {"tech_reborn_servo_" .. s .. "_" .. n .. ".png^tech_reborn_servo_overlay_" .. n .. ".png"},
		  on_activate = function(self, staticdata) 
		  	self.object:set_yaw(90 * 0.0174533)
		  	self.io = s
		  	activate_servo(self, staticdata)
		  end,
		}
		for k,v in pairs(base_table) do table[k] = v end
		for k,v in pairs(servo_table) do table[k] = v end
		minetest.register_entity("tech_reborn:servo_" .. s .. "_" .. n .. "_z", table)
	end

	--
	-- Preview Initialization
	--
	n = n - 2
	local scale = 0.255 * (n / 8)

	table = {
	  collisionbox = {-scale, -(scale * wmod[n]), -scale, scale, (scale * wmod[n]), scale},
	  mesh = "tech_reborn_servo_top_" .. n .. ".x",
	  on_activate = function(self, staticdata) 
	  	activate_preview(self, staticdata)
	  end,
	}
	for k,v in pairs(base_table) do table[k] = v end
	for k,v in pairs(preview_table) do table[k] = v end
	minetest.register_entity("tech_reborn:servo_preview_" .. n .. "_y", table)

	table = {
	  collisionbox = {-(scale * wmod[n]), -scale, -scale, (scale * wmod[n]), scale, scale},
	  mesh = "tech_reborn_servo_side_" .. n .. ".x",
	  on_activate = function(self, staticdata) 
	  	activate_preview(self, staticdata)
	  end,
	}
	for k,v in pairs(base_table) do table[k] = v end
	for k,v in pairs(preview_table) do table[k] = v end
	minetest.register_entity("tech_reborn:servo_preview_" .. n .. "_x", table)

	table = {
		collisionbox = {-scale, -scale, -(scale * wmod[n]), scale, scale, (scale * wmod[n])},
	  mesh = "tech_reborn_servo_side_" .. n .. ".x",
	  on_activate = function(self, staticdata) 
	  	self.object:set_yaw(90 * 0.0174533)
	  	activate_preview(self, staticdata)
	  end,
	}
	for k,v in pairs(base_table) do table[k] = v end
	for k,v in pairs(preview_table) do table[k] = v end
	minetest.register_entity("tech_reborn:servo_preview_" .. n .. "_z", table)
end