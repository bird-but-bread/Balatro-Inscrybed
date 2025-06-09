local beast_deck = {
    object_type = "Back",
    name = "insc-beast",
    key = "beast_deck",
    pos = { x = 0, y = 0 },
    config = { extra = {check = true, mult = 10, } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    calculate = function(self, back, context)
        if context.individual and context.cardarea == G.play then
            for i = 1, #context.scoring_hand do
                if back.effect.config.extra.check == true then
                    local card_ = context.scoring_hand[i]
                    if SMODS.has_enhancement(card_, "m_wild") then
                        card_.ability.perma_mult = card_.ability.perma_mult or 0
                        card_.ability.perma_mult = card_.ability.perma_mult + back.effect.config.extra.mult
                    
                        back.effect.config.extra.check = false
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(card_, nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card.states.visible = nil
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        })) 
                    end  
                end
            end
        end
        if context.end_of_round then
            back.effect.config.extra.check = true
        end
    end,
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                create_consumable("Tarot", nil, nil, {forced_key='c_lovers'})
                create_consumable("Tarot", nil, nil, {forced_key='c_lovers'})
                return true
            end
        }))
    end,
    atlas = "leshy_cards",
}
return {name = {"Decks"}, items = {beast_deck}}