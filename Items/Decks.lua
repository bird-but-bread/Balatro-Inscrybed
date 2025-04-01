SMODS.Back {
    name = "insc-beast",
    key = "beast_deck",
    pos = { x = 0, y = 0 },
    config = { extra = {check = true, chips = 10 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    calculate = function(self, back, context)
        if context.main_scoring and context.cardarea == G.play and back.ability.extra.check == true then
            for i = 1, #context.scoring_hand do
                card_ = context.scoring_hand[i]
                if SMODS.has_enhancement(card_, "m_wild") then
                    back.ability.extra.check = false
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
                    _card.ability.perma_bonus = _card.ability.perma_bonus or 0
                    _card.ability.perma_bonus = _card.ability.perma_bonus + back.ability.extra.chips
                end
            end
        end
        if context.end_of_round then
            back.ability.extra.check = true
        end
    end,
    atlas = "beast",
}