local double = {
    object_type = "Sigil",
    name = "insc_Double_Strike",
    key = "double",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}
return {name = {"Sigils"}, items = {double}}