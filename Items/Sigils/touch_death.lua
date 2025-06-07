local touch_death = {
    object_type = "Sigil",
    name = "insc_Touch_of_Death",
    key = "touch_death", --Please dont
    badge_colour = HEX("9fff80"),
    config = {xmult = 0, x_mult_mod = 1.5},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=3},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].xmult, card.ability.sigil[index].x_mult_mod} }
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
            if card.ability.sigil[index].xmult ~= 0 then
                SMODS.calculate_effect({x_mult_mod = card.ability.sigil[index].xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil[index].xmult}}}, card)
            end
            if #G.jokers.cards ~= 0 then
                card.ability.sigil[index].xmult = card.ability.sigil[index].xmult + card.ability.sigil[index].x_mult_mod
                local jindex = math.random(1,#G.jokers.cards)
                G.jokers.cards[jindex]:start_dissolve()
            end
            
        end
    end,
}
return {name = {"Sigils"}, items = {touch_death}}