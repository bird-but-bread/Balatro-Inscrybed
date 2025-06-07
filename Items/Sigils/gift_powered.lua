local gift_powered = {
    object_type = "Sigil",
    name = "insc_Gift_When_Powered",
    key = "gift_powered",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before then
            if card.ability.in_between_circuit then
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
                         if #G.jokers.cards < G.jokers.config.card_limit then 
                            local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gift_powered')
                            card_:add_to_deck()
                            G.jokers:emplace(card_)
                            card_:start_materialize()
                            G.GAME.joker_buffer = 0
                            return
                        end
                    end
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {gift_powered}}