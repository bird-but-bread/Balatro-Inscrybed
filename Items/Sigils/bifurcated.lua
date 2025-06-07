local bifurcated = {
    object_type = "Sigil",
    name = "insc_Bifurcated_Strike",
    key = "bifurcated",
    badge_colour = HEX("9fff80"),
    config = {furcated = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
return {name = {"Sigils"}, items = {bifurcated}}