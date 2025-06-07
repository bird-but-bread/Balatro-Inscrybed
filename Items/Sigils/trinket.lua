local trinket = {
    object_type = "Sigil",
    name = "insc_Trinket_Bearer",
    key = "trinket",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local _card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, nil, 'trinket')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card:juice_up(0.3, 0.5)
                end
                return true end }))
            delay(0.6)
        end
    end
}
return {name = {"Sigils"}, items = {trinket}}