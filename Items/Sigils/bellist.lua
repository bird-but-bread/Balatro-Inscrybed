local bellist = {
    object_type = "Sigil",
    name = "insc_Bellist",
    key = "bellist",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=4},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand and not context.end_of_round then
            local valid_cards = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i] == card then
                    if #G.hand.cards == 1 then
                        table.insert(valid_cards, G.hand.cards[i])
                    elseif i == 1 then
                        table.insert(valid_cards, G.hand.cards[i+1])
                        table.insert(valid_cards, G.hand.cards[i])
                    elseif i == #G.hand.cards then
                        table.insert(valid_cards, G.hand.cards[i-1])
                        table.insert(valid_cards, G.hand.cards[i])
                    else
                        table.insert(valid_cards, G.hand.cards[i+1])
                        table.insert(valid_cards, G.hand.cards[i])
                        table.insert(valid_cards, G.hand.cards[i-1])
                    end
                end
            end
            for i = 1, #valid_cards do
                if valid_cards[i].config.center.key ~= "c_base" then
                    local effect = G.P_CENTERS[valid_cards[i].config.center.key].config
                    local scored_card = valid_cards[i]
                    for _, key in ipairs(SMODS.calculation_keys) do
                        if effect["bonus"] ~= nil then
                            effect = {chips = effect["bonus"]}
                        end
                        if effect[key] and key ~= "extra" then
                            if effect.juice_card then G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function () effect.juice_card:juice_up(0.1); scored_card:juice_up(0.1); return true end})) end
                            SMODS.calculate_individual_effect(effect, scored_card, key, effect[key])
                        end
                    end
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {bellist}}