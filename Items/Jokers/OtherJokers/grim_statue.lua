local grim_statue = {
    object_type = "Joker",
    name = "GrimStatue",
    key = "grim_statue",
    pos = { x = 0, y = 1 },
    config = { scribe = "Grimora" },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    no_ui = true,
    discovered = true,
    alt_ui = true,
    yes_pool_flag = 'scribe_no_grim_flag',
    no_collection = true,
    rarity = 1,
    cost = 0,
    blueprint_compat = false,
    atlas = "scribe_statues",
}
return {name = {"OtherJoker"}, items = {grim_statue}}