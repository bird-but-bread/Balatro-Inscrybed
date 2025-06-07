local shield_latch = {
    object_type = "Sigil",
    name = "insc_Shield_Latch",
    key = "shield_latch",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_chariot", 'trinket')
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            card:juice_up(0.3, 0.5)
                        end
                        return true end }))
                    delay(0.6)
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {shield_latch}}