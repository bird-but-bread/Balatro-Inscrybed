local morsel = {
    object_type = "Sigil",
    name = "insc_Morsel",
    key = "morsel",
    badge_colour = HEX("9fff80"),
    config = { trigger = false },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=6},
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
                if G.GAME.last_hand_played ~= nil then
                    local hand_type = G.GAME.last_hand_played
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(hand_type, 'poker_hands'),chips = G.GAME.hands[hand_type].chips, mult = G.GAME.hands[hand_type].mult, level=G.GAME.hands[hand_type].level})
                    level_up_hand(card, hand_type, nil, 1)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                    delay(0.4)
                    card:start_dissolve()
                    card.ability.sigil[index].trigger = true
                end
            end 
        end
    end
}
return {name = {"Sigils"}, items = {morsel}}