local parasite = {
    object_type = "Sigil",
    name = "insc_Brood_Parasite",
    key = "parasite",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            if #G.jokers.cards < G.jokers.config.card_limit then 
                local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_egg", 'parasite')
                card_:add_to_deck()
                G.jokers:emplace(card_)
                card_:start_materialize()
                G.GAME.joker_buffer = 0
                return{
                    message = {
                        "egg!"
                    }
                }
            end
        end
    end
}
return {name = {"Sigils"}, items = {parasite}}