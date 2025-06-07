local frozen = {
    object_type = "Sigil",
    name = "insc_Frozen_Away",
    key = "frozen",
    badge_colour = HEX("9fff80"),
    config = {chips = 30, mult = 15},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=6},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].chips, card.ability.sigil[index].mult} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    local index = nil
                    if card.sigil ~= nil then
                        if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                            index = 1
                        elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                            index = 2
                        end
                    end
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(card, nil, nil, G.playing_card)
                    _card:set_sigil(nil, index)
                    _card.ability.perma_bonus = _card.ability.perma_bonus + card.ability.sigil[index].chips
                    _card.ability.perma_mult = _card.ability.perma_mult + card.ability.sigil[index].mult
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
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {frozen}}