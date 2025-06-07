local deathcard = {
    object_type = "Joker",
    name = "insc-deathcard",
    key = "deathcard",
    pos = { x = 0, y = 0 },
    soul_pos = {
        x = 1, 
        y = 0,
        holo = true
    },
    insc_num_layer = {
        x = 2, 
        y = 0,
        holo = true,
    },
    config = { insc_sacrifice_sigils = {"trinket"}, extra = { } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    rarity = 1,
    cost = 20,
    blueprint_compat = true,
    atlas = "po3_cards",
}
return {name = {"OtherJoker"}, items = {deathcard}}