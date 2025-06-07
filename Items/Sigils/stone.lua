local stone = {
    object_type = "Sigil",
    name = "insc_Made_of_Stone",
    key = "stone",
    badge_colour = HEX("9fff80"),
    config = {counts_as_enhance = "m_stone"},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=3, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
return {name = {"Sigils"}, items = {stone}}