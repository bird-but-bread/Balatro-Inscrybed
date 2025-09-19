local bullfrog = {
    object_type = "Joker",
    name = "Bullfrog",
    key = "bullfrog",
    insc_type = "Reptile",
    pos = { x = 4, y = 2 },
    config = { insc_sacrifice_sigils = {"mighty_leap"}, extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 1,
    cost = 4,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local temp_Mult, temp_ID = 15, 15
            local dia_card = nil
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Diamonds') then
                    if dia_card then
                        if temp_ID >= context.scoring_hand[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then 
                            temp_Mult = context.scoring_hand[i].base.nominal
                            temp_ID = context.scoring_hand[i].base.id
                            dia_card = context.scoring_hand[i]
                        end
                    else
                        temp_Mult = context.scoring_hand[i].base.nominal
                        temp_ID = context.scoring_hand[i].base.id
                        dia_card = context.scoring_hand[i]
                    end
                end
            end
            if dia_card then
                if dia_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = dia_card,
                    }
                else
                    return {
                        mult = 2*temp_Mult,
                        card = dia_card,
                    }
                end
            end
        end
    end
}
return {name = {"BeastJokers"}, items = {bullfrog}}