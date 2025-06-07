local overclocked = {
    object_type = "Sigil",
    name = "insc_Overclocked",
    key = "overclocked",
    badge_colour = HEX("9fff80"),
    config = { x_mult = 2, odds = 2 },
    loc_vars = function(self, info_queue)
        return { vars = { self.config.x_mult, G.GAME.probabilities.normal or 1, self.config.odds} }
    end,
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=1, y=2},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = self.config.x_mult,
            }
        end
        if context.destroying_card and (hand_chips * mult) + G.GAME.chips < G.GAME.blind.chips then 
            if pseudorandom('overclocked') < G.GAME.probabilities.normal / self.config.odds then
                return { remove = true }
            end
        end
    end,
}
return {name = {"Sigils"}, items = {overclocked}}