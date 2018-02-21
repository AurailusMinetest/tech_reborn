--
-- Battery Formspec
--
function make_battery_formspec(pos)
  local meta = minetest.get_meta(pos)

  local power = meta:get_int("power")
  local capacity = meta:get_int("capacity")
  local n = math.floor(meta:get_int("power") / meta:get_int("capacity") * 10)

  local fs = [[
    size[9,8;]
    bgcolor[#222222EE;false]
    listcolors[#cccccc55;#ffffff55;#888888;#33333399;#ffffff]
    label[3.2,0.5;Energy: ]] .. power .. [[ ME / ]] .. capacity .. [[ ME]

    image[2.65,0.8;3,3;tech_reborn_battery_]] .. n .. [[.png]

    label[0.5,3.5;Inventory]
    list[current_player;main;0.5,4;8,3;8]
    list[current_player;main;0.5,7.2;8,1;]

    label[1,0.8;Charge]
    list[current_player;main;1,1.2;2,2;]

    field[6.2,1;2.2,2;input;               Input (Max: 50);50]
    field[6.2,2.1;2.2,2;output;            Output (Max: 50);50]
  ]]
  meta:set_string("formspec", fs)
end

--
-- Register The Battery and all of it's States
--
for n = 0, 10 do
  local groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wire_connect = 1}
  if n ~= 10 then
    groups.not_in_creative_inventory = 1
  end
  minetest.register_node("tech_reborn:battery_" .. n, {
      description = "Battery",
      tiles = {
  	  	"tech_reborn_machine.png",
  	  	"tech_reborn_machine.png",
  	  	"tech_reborn_machine.png^tech_reborn_battery_" .. n .. ".png",
  	  	"tech_reborn_machine.png^tech_reborn_battery_" .. n .. ".png",
  	  	"tech_reborn_machine.png^tech_reborn_battery_" .. n .. ".png",
  	    "tech_reborn_machine.png^tech_reborn_battery_" .. n .. ".png",
    	},
    	paramtype2 = "facedir",
      on_construct = function(pos)
        local timer = minetest.get_node_timer(pos)
        if timer and not timer:is_started() then
          timer:start(0.1)
        end
        
        -- Set Variables
        local meta = minetest.get_meta(pos)
        meta:set_int("power", 0)
        meta:set_int("capacity", 4000)

        -- Create formspec
        make_battery_formspec(pos)
        
        -- Prevent Stupid
        minetest.swap_node(pos, {name = "tech_reborn:battery_0"})
      end,
      groups = groups,
      sounds = default.node_sound_metal_defaults(),
      drop = "tech_reborn:battery_10",
      node_placement_prediction = "tech_reborn:battery_0",
      on_timer = function(pos)
        -- Get Meta & Space
        local meta = minetest.get_meta(pos)
        -- Attempt to share power
        local space = math.min(50, meta:get_int("capacity") - meta:get_int("power"))
        meta:set_int("power", meta:get_int("power") + tech_reborn.pullAdjacentEnergy(pos, space))
        local give = math.min(meta:get_int("power"), 50)
        meta:set_int("power", meta:get_int("power") - tech_reborn.pushAdjacentEnergy(pos, give))

        -- Update formspec
        make_battery_formspec(pos)

        -- Display Power Meta
        minetest.get_meta(pos):set_string("infotext", "Power Stored: " .. meta:get_int("power") .. " ME")

        -- Change node textures
        local n = math.floor(meta:get_int("power") / meta:get_int("capacity") * 10)
        minetest.swap_node(pos, {name = "tech_reborn:battery_" .. n})
        
        return true
      end
  })
end