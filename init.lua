raining_items = {}

local timer = 0

minetest.register_on_mods_loaded(function()
    for item, def in pairs(minetest.registered_items) do
        if item ~= "" and item ~= "air" and item ~= "ignore" and item ~= "unknown" and def and def.description and def.description ~= "" and def._tt_ignore ~= true and def.groups.not_in_creative_inventory ~= 1 then
            table.insert(raining_items, item)
        end
    end
end)

minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 0.6 then
        for _, player in pairs(minetest.get_connected_players()) do
            local ppos = player:get_pos()
            local pos = { x = ppos.x + math.random(-20, 20), y = player:get_clouds().height, z = ppos.z + math.random(-20, 20) }
            if minetest.get_node(pos).name == "air" then
                minetest.add_item(pos, raining_items[math.random(#raining_items)])
            end
        end
        timer = 0
    end
end)
