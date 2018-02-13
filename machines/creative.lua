minetest.register_node("tech_reborn:tech_reborn_creative_emitter", {
    description = "Creative Power Emitter",
    tiles = {
      "tech_reborn_machine.png^tech_reborn_creative_emitter.png",
    },
    on_construct = function(pos)
      tech_reborn.wire.recalcModels(pos)
    end,
    after_destruct = function(pos)
      tech_reborn.wire.recalcModels(pos)
    end,
    groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wired_node = 1, dig_immediate = 3},
    sounds = default.node_sound_metal_defaults(),
    machine_update = function(pos)
      tech_reborn.pushAdjacentEnergy(pos, 50)
    end,
})

minetest.register_node("tech_reborn:tech_reborn_creative_consumer", {
    description = "Creative Power Consumer",
    tiles = {
      "tech_reborn_machine.png^tech_reborn_creative_consumer.png",
    },
    on_construct = function(pos)
      tech_reborn.wire.recalcModels(pos)
    end,
    after_destruct = function(pos)
      tech_reborn.wire.recalcModels(pos)
    end,
    groups = {cracky = 1, oddly_breakable_by_hand = 1, machine = 1, wired_node = 1, dig_immediate = 3},
    sounds = default.node_sound_metal_defaults(),
    machine_update = function(pos)
      tech_reborn.pullAdjacentEnergy(pos, 50)
    end,
})
