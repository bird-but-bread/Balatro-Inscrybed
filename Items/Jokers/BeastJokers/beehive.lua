local beehive = {
    object_type = "Joker",
    name = "Beehive",
    key = "beehive",
    insc_type = "Insect",
    pos = { x = 2, y = 2 },
    config = { insc_sacrifice_sigils = {"bees_within"}, extra = { copies = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.copies } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 2,
    cost = 6,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.selling_card and context.card == card then
            for i = 1, card.ability.extra.copies do
                if #G.jokers.cards <= G.jokers.config.card_limit then 
                    local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_insc_bee", 'beehive')
                    card_:add_to_deck()
                    G.jokers:emplace(card_)
                    card_:start_materialize()
                    G.GAME.joker_buffer = 0
                end
            end
        end
    end
}
return {name = {"BeastJokers"}, items = {beehive}}