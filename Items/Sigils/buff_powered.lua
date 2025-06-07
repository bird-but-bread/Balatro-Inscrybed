local buff_powered = {
    object_type = "Sigil",
    name = "insc_Buff_When_Powered",
    key = "buff_powered",
    badge_colour = HEX("9fff80"),
    config = {x_mult = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=4},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].x_mult} }
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
            if card.ability.in_between_circuit then
                SMODS.calculate_effect({Xmult_mod = card.ability.sigil[index].x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil[index].x_mult}}}, card)
            end
        end
    end,
}
return {name = {"Sigils"}, items = {buff_powered}}