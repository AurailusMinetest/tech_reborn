minetest.register_node("tech_reborn:tech_reborn_creative_emitter", {
    description = "Creative Power Emitter",
    tiles = {
      "tech_reborn_machine.png^tech_reborn_creative_emitter.png",
    },
    groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wire_connect = 1, dig_immediate = 3},
    sounds = default.node_sound_metal_defaults(),
    on_timer = function(pos)
      tech_reborn.pushAdjacentEnergy(pos, 10)
      return true
    end,
    on_construct = function(pos)
      local timer = minetest.get_node_timer(pos)
      if timer and not timer:is_started() then
        timer:start(0.1)
      end
    end,
})

minetest.register_node("tech_reborn:tech_reborn_creative_consumer", {
    description = "Creative Power Consumer",
    tiles = {
      "tech_reborn_machine.png^tech_reborn_creative_consumer.png",
    },
    groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wire_connect = 1, dig_immediate = 3},
    sounds = default.node_sound_metal_defaults(),
    on_timer = function(pos)
      tech_reborn.pullAdjacentEnergy(pos, 50)
      return true
    end,
    on_construct = function(pos)
      local timer = minetest.get_node_timer(pos)
      if timer and not timer:is_started() then
        timer:start(0.1)
      end
    end,
})
