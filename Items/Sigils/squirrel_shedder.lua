local squirrel_shedder = {
    object_type = "Sigil",
    ignore = true, -- No art yet
    name = "insc_squirrel_shedder",
    key = "squirrel_shedder",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
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
                if #G.jokers.cards < G.jokers.config.card_limit then 
                    local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_insc_squirrel", 'leshy_replaced')
                    card_:add_to_deck()
                    G.jokers:emplace(card_)
                    card_:start_materialize()
                    G.GAME.joker_buffer = 0
                end
            end 
        end
    end
}
return {name = {"Sigils"}, items = {squirrel_shedder}}