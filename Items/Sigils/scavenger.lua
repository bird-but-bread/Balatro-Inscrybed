local scavenger = {
    object_type = "Sigil",
    name = "insc_Scavenger",
    key = "scavenger",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            if G.GAME.current_round.discards_used ~= 0 then
                return {
                    dollars = (G.GAME.current_round.discards_used*2),
                    colour = G.C.MONEY
                }
            end
        end
    end,
}
return {name = {"Sigils"}, items = {scavenger}}