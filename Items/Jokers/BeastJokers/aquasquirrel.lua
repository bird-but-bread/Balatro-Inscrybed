local aquasquirrel = {
    object_type = "Joker",
    name = "Aquasquirrel",
    key = "aquasquirrel",
    insc_type = "None",
    pos = { x = 3, y = 0 },
    config = { insc_sacrifice_sigils = {"waterborne"}, extra = { } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 1,
    cost = 0,
    order = 1,
    blueprint_compat = false,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        -- Nope
    end
}
return {name = {"BeastJokers"}, items = {aquasquirrel}}