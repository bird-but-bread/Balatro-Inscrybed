local brittle = {
    object_type = "Sigil",
    name = "insc_Brittle",
    key = "brittle",
    badge_colour = HEX("9fff80"),
    config = { odds = 4, chips = 100 },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=5},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds, card.ability.sigil[index].chips } }
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
        if context.main_scoring and context.cardarea == G.play then
            SMODS.calculate_effect({chip_mod = card.ability.sigil[index].chips, message = localize{type='variable',key='a_chips',vars={card.ability.sigil[index].chips}}}, card)
        end
        if context.final_scoring_step and context.cardarea == G.play then
            if pseudorandom('brittle') < G.GAME.probabilities.normal/card.ability.sigil[index].odds then
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function() 
                    card:shatter()
                    return true end }))
            end
        end
    end,
}
return {name = {"Sigils"}, items = {brittle}}