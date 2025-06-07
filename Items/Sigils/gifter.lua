local gifter = {
    object_type = "Sigil",
    name = "insc_Gift_Bearer",
    key = "gifter",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=2},
    loc_vars = function(self, info_queue, card)
    return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            if #G.jokers.cards < G.jokers.config.card_limit then 
                local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gifter')
                card_:add_to_deck()
                G.jokers:emplace(card_)
                card_:start_materialize()
                G.GAME.joker_buffer = 0
                return{
                    message = {
                        "gift!"
                    }
                }
            end
        end
    end
}
return {name = {"Sigils"}, items = {gifter}}