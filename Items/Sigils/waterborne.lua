local waterborne = {
    object_type = "Sigil",
    name = "insc_Waterborne",
    key = "waterborne",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=11, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    update = function(self, card, dt)
        if card.debuff then
            card.debuff = false
        end
    end,
}
return {name = {"Sigils"}, items = {waterborne}}