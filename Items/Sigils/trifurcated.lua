local trifurcated = {
    object_type = "Sigil",
    name = "insc_Trifurcated_Strike",
    key = "trifurcated",
    badge_colour = HEX("9fff80"),
    config = {furcated = 3},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
return {name = {"Sigils"}, items = {trifurcated}}