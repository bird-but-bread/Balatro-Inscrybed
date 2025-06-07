local sacrifice = {
    object_type = "Sigil",
    name = "insc_Worthy_Sacrifice",
    key = "sacrifice",
    badge_colour = HEX("9fff80"),
    config = {extra = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=3},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.extra+1}
        }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            G.GAME.insc_extra_draw = G.GAME.insc_extra_draw + self.config.extra
        end
    end
}
return {name = {"Sigils"}, items = {sacrifice}}