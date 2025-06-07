local burrower = {
    object_type = "Sigil",
    name = "insc_Burrower",
    key = "burrower",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local unscoring_cards = {}
            local scoring_lookup = {}
            for i = 1, #context.scoring_hand do
                scoring_lookup[context.scoring_hand[i]] = true
            end
            for i = 1, #context.full_hand do
                local _card = context.full_hand[i]
                if not scoring_lookup[_card] then
                    table.insert(unscoring_cards, _card)
                end
            end
            for i = 1, #unscoring_cards do
                if card == unscoring_cards[i] then
                    G.GAME.insc_extra_draw = G.GAME.insc_extra_draw + 1
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {burrower}}