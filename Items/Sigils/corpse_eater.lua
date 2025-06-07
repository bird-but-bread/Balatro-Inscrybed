local corpse_eater = {
    object_type = "Sigil",
    ignore = true,
    name = "insc_Corpse_Eater",
    key = "corpse_eater",
    badge_colour = HEX("9fff80"),
    config = { insert_in_deck = {false, "length"}, context_discard = false, context_hand = false },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}
return {name = {"Sigils"}, items = {corpse_eater}}