local bees_within = {
    object_type = "Sigil",
    name = "insc_bees_within",
    key = "bees_within",
    badge_colour = HEX("9fff80"),
    config = { odds = 4 },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=5},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds } }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.discard and context.other_card == card then
            if card.sigil[index] ~= nil then
                local sigil = card.ability.sigil[index]
                if pseudorandom('bees_within') < G.GAME.probabilities.normal/sigil.odds then
                    if #G.jokers.cards < G.jokers.config.card_limit then 
                        local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_insc_beehive", 'bees_within')
                        card_:add_to_deck()
                        G.jokers:emplace(card_)
                        card_:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
                else
                    if #G.jokers.cards < G.jokers.config.card_limit then 
                        local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_insc_bee", 'bees_within')
                        card_:add_to_deck()
                        G.jokers:emplace(card_)
                        card_:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
                end
            end 
        end
    end
}
return {name = {"Sigils"}, items = {bees_within}}