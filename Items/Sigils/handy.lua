local handy = {
    object_type = "Sigil",
    name = "insc_Handy",
    key = "handy",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            local cards = {}
            local destroyed_cards = {}
            for i=1, #G.hand.cards do
                G.hand.cards[i]:calculate_seal({discard = true})
                local removed = false
                for j = 1, #G.jokers.cards do
                    local eval = nil
                    eval = G.jokers.cards[j]:calculate_joker({discard = true, other_card =  G.hand.cards[i], full_hand = G.hand.cards})
                    if eval then
                        if eval.remove then removed = true end
                        card_eval_status_text(G.jokers.cards[j], 'jokers', nil, 1, nil, eval)
                    end
                end
                table.insert(cards, G.hand.cards[i])
                if removed then
                    destroyed_cards[#destroyed_cards + 1] = G.hand.cards[i]
                    if G.hand.cards[i].ability.name == 'Glass Card' then 
                        G.hand.cards[i]:shatter()
                    else
                        G.hand.cards[i]:start_dissolve()
                    end
                else 
                    G.hand.cards[i].ability.discarded = true
                    draw_card(G.hand, G.discard, i*100/#G.hand.cards, 'down', false, G.hand.cards[i])
                end
            end
            local hand_space = math.min(#G.deck.cards, G.hand.config.card_limit - #G.hand.cards)
            delay(0.3)
            for i=1, hand_space do 
                if G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK then 
                    draw_card(G.deck,G.hand, i*100/hand_space,'up', true)
                else
                    draw_card(G.deck,G.hand, i*100/hand_space,'up', true)
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {handy}}