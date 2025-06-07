local fledgling = {
    object_type = "Sigil",
    name = "insc_Fledgling",
    key = "fledgling",
    badge_colour = HEX("9fff80"),
    config = {mult = 0, mult_mod = 5},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=11, y=5},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].mult, card.ability.sigil[index].mult_mod} }
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
            if card.ability.sigil[index].mult ~= 0 then
                SMODS.calculate_effect({mult_mod = card.ability.sigil[index].mult, message = localize{type='variable',key='a_mult',vars={card.ability.sigil[index].mult}}}, card)
            end
        end
        if context.before then
            local unscoring_cards = {}
            local scoring_lookup = {}
            for i = 1, #context.scoring_hand do
                scoring_lookup[context.scoring_hand[i]] = true
            end
            for i = 1, #context.full_hand do
                local _card = context.full_hand[i]
                if not scoring_lookup[_card] then
                    table.insert(unscoring_cards, _card)
                end
            end
            for i = 1, #unscoring_cards do
                if card == unscoring_cards[i] then
                    card.ability.sigil[index].mult = card.ability.sigil[index].mult + card.ability.sigil[index].mult_mod
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {fledgling}}