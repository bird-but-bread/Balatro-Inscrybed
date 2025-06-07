local airborne = {
    object_type = "Sigil",
    name = "insc_Airborne",
    key = "airborne",
    badge_colour = HEX("9fff80"),
    config = {always_scores = true,},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=7},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
return {name = {"Sigils"}, items = {airborne}}