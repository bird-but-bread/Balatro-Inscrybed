local tail = {
    object_type = "Sigil",
    name = "insc_Loose_Tail",
    key = "tail",
    badge_colour = HEX("9fff80"),
    config = {no_destroy = {true, true, 1}},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=5},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
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
                    if card.ability.sigil[index].no_destroy[3] ~= nil and card.ability.sigil[index].no_destroy[3] ~= 0 then
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(card, nil, nil, G.playing_card)
                        local _suit = string.sub(card.base.suit, 1, 1)..'_'
                        local rank_suffix = card.base.id == 14 and 2 or math.min(math.floor(card.base.id / 2), 14)
                        if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                        elseif rank_suffix == 10 then rank_suffix = 'T'
                        elseif rank_suffix == 11 then rank_suffix = 'J'
                        elseif rank_suffix == 12 then rank_suffix = 'Q'
                        elseif rank_suffix == 13 then rank_suffix = 'K'
                        elseif rank_suffix == 14 then rank_suffix = 'A'
                        end
                        _card:set_base(G.P_CARDS[_suit..rank_suffix])
                        _card:set_sigil(nil, index)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
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
    end
}
return {name = {"Sigils"}, items = {tail}}