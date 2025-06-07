local mighty_leap = {
    object_type = "Sigil",
    name = "insc_Mighty_Leap",
    key = "mighty_leap",
    badge_colour = HEX("9fff80"),
    config = { trigger = false },
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
                if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                    G.GAME.blind:disable()
                    card:start_dissolve()
                    card.ability.sigil[index].trigger = true
                end
            end 
        end
        if context.destroying_card and card.ability.sigil[index].trigger then 
            return { remove = true }
        end
    end
}
return {name = {"Sigils"}, items = {mighty_leap}}