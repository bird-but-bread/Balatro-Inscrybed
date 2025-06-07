local dam_builder = {
    object_type = "Sigil",
    name = "insc_Dam_Builder",
    key = "dam_builder",
    badge_colour = HEX("9fff80"),
    config = { trigger = true },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=1, y=4},
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
        if context.before and context.cardarea == G.play and card.ability.sigil[index].trigger then
            local _card = copy_card(card, nil, nil, G.playing_card)
            _card:set_ability(G.P_CENTERS.m_stone, nil)
            _card.ability.sigil_destroy_self = true
            _card:set_seal()
            _card:set_sigil(nil, 1)
            _card:set_sigil(nil, 2)
            table.insert(context.scoring_hand, _card)
            G.play:emplace(_card)
            _card:highlight(true)
            local _card_ = copy_card(card, nil, nil, G.playing_card)
            _card_:set_ability(G.P_CENTERS.m_stone, nil)
            _card_.ability.sigil_destroy_self = true
            _card_:set_seal()
            _card_:set_sigil(nil, 1)
            _card_:set_sigil(nil, 2)
            table.insert(context.scoring_hand, _card_)
            G.play:emplace(_card_)
            _card_:highlight(true)
        end
        if context.hand_drawn then
            card.ability.sigil[index].trigger = true
        end
    end
}
return {name = {"Sigils"}, items = {dam_builder}}