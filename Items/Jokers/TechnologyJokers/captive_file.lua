local captive_file = {
    object_type = "Joker",
    name = "insc_Hostage",
    key = "captive_file",
    pos = { x = 0, y = 1 },
    soul_pos = {
        x = 1, 
        y = 1,
        holo = true
    },
    insc_num_layer = {
        x = 2, 
        y = 1,
        holo = true,
    },
    config = { insc_sacrifice_sigils = {"hostage_file"}, extra = { } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_tech_card',
    discovered = false,
    eternal_compat = false,
    rarity = 1,
    order = 2,
    cost = 20,
    blueprint_compat = false,
    atlas = "po3_cards",
    calculate = function(self, card, context)
        if context.game_over then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    local destructable_jokers = {}
                    for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
                    end
                    local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('captive_file')) or nil

                    if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then 
                        joker_to_destroy.getting_sliced = true
                        G.E_MANAGER:add_event(Event({func = function()
                            joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                        return true end }))
                    end
                    return true
                end
            })) 
            return {
                message = "Bang!",
                saved = true,
                colour = G.C.TECH
            }
        end
    end,

}
return {name = {"TechnologyJokers"}, items = {captive_file}}