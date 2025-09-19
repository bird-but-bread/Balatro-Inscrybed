local bee = {
    object_type = "Joker",
    name = "Bee",
    key = "bee",
    insc_type = "Insect",
    pos = { x = 0, y = 1 },
    config = { insc_sacrifice_sigils = {"airborne"}, extra = { perma_bonus = 0, perma_bonus_mod = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.perma_bonus_mod, card.ability.extra.perma_bonus } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 1,
    cost = 4,
    order = 1,
    blueprint_compat = true,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].sigil ~= nil then
                    if context.scoring_hand[i].sigil[1] ~= nil and context.scoring_hand[i].sigil[1] == "insc_bees_within_sigil" then
                        card.ability.extra.perma_bonus = card.ability.extra.perma_bonus + card.ability.extra.perma_bonus_mod
                    end
                    if context.scoring_hand[i].sigil[2] ~= nil and context.scoring_hand[i].sigil[2] == "insc_bees_within_sigil" then
                        card.ability.extra.perma_bonus = card.ability.extra.perma_bonus + card.ability.extra.perma_bonus_mod
                    end
                end
            end
            if context.other_card:is_suit('Spades') then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.perma_bonus
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                    card = context.other_card
                }
            end
        end
    end,
    update = function(self, card, dt)
        if G.jokers ~= nil then
            card.ability.extra.perma_bonus = (#SMODS.find_card("j_insc_bee") + #SMODS.find_card("j_insc_beehive")) * card.ability.extra.perma_bonus_mod
        end
    end
}
return {name = {"BeastJokers"}, items = {bee}}