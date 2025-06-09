local alpha = {
    object_type = "Joker",
    name = "insc_alpha",
    key = "alpha",
    pos = { x = 1, y = 2 },
    config = { insc_sacrifice_sigils = {"leader"}, extra = { mult = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 2,
    cost = 6,
    order = 1,
    blueprint_compat = true,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.joker_main then
            return {
				mult = card.ability.extra.mult,
				card = card
			}
        end
    end,
    update = function(self, card, dt)
        card.ability.extra.mult = 0
        if G.jokers ~= nil then
            for i = 1, #G.jokers.cards do
                local other_joker = G.jokers.cards[i]
                if not other_joker.debuff then
                    if other_joker.config.center.rarity == 1 then
				        card.ability.extra.mult = card.ability.extra.mult + 5
                    elseif other_joker.config.center.rarity == 2 then
				        card.ability.extra.mult = card.ability.extra.mult + 10
                    elseif other_joker.config.center.rarity == 3 then
				        card.ability.extra.mult = card.ability.extra.mult + 20
                    elseif other_joker.config.center.rarity == 4 then
				        card.ability.extra.mult = card.ability.extra.mult + 50
                    end
                end
            end
        end
    end
}
return {name = {"BeastJokers"}, items = {alpha}}