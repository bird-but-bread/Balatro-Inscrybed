local armored = {
    object_type = "Sigil",
    name = "insc_Armored",
    key = "armored",
    badge_colour = HEX("9fff80"),
    config = { no_discard_score = {false, "hand"} },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=3},
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
        if context.main_scoring and context.cardarea == G.play then
            card.ability.sigil[index].no_discard_score[1] = true
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
                    card.ability.sigil[index].no_discard_score[1] = false
                end
            end
        end
    end,
}
return {name = {"Sigils"}, items = {armored}}