local lives = {
    object_type = "Sigil",
    name = "insc_Many_Lives",
    key = "lives",
    badge_colour = HEX("9fff80"),
    config = {no_discard_score = {true, "deck"}, no_discard_hand = true, no_destroy = {true, false}},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
return {name = {"Sigils"}, items = {lives}}