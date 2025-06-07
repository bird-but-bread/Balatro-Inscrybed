local po3_statue = {
    object_type = "Joker",
    name = "Po3Statue",
    key = "po3_statue",
    pos = { x = 0, y = 0 },
    config = { scribe = "PO3" },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    no_ui = true,
    discovered = true,
    alt_ui = true,
    yes_pool_flag = 'scribe_no_po3_flag',
    no_collection = true,
    rarity = 1,
    cost = 0,
    blueprint_compat = false,
    atlas = "scribe_statues",
}
return {name = {"OtherJoker"}, items = {po3_statue}}