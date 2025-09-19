local bloodhound = {
    object_type = "Joker",
    name = "Bloodhound",
    key = "bloodhound",
    insc_type = "Canine",
    pos = { x = 3, y = 2 },
    config = { insc_sacrifice_sigils = {"guardian"}, extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 2,
    cost = 6,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local level_hand = true
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i]:is_suit('Hearts') then
                    level_hand = false
                end
            end
            if level_hand then
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}
return {name = {"BeastJokers"}, items = {bloodhound}}