local adder = {
    object_type = "Joker",
    name = "Adder",
    key = "adder",
    insc_type = "Reptile",
    pos = { x = 2, y = 1 },
    config = { insc_sacrifice_sigils = {"touch_death"}, extra = { x_mult = 1.2, destroyed_jokers = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.destroyed_jokers } }
    end,
    yes_pool_flag = 'insc_beast_card',
    discovered = false,
    rarity = 2,
    cost = 6,
    order = 1,
    blueprint_compat = true,
    atlas = "leshy_cards",
    calculate = function(self, card, context)
        if context.repetition_only or (context.retrigger_joker_check) then
            if card.ability.extra.destroyed_jokers > 0 then
                if context.other_card == card then
                    return {
                        repetitions = card.ability.extra.destroyed_jokers,
                        card = card,
                        message = localize('k_again_ex')
                    }  
                end
            end
        end
        if context.joker_main then
            return {
                colour = G.C.RED,
				x_mult = card.ability.extra.x_mult,
				card = card
			}
        end
    end
}
local start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
  local ref = start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
  if G.jokers and self.ability.set == 'Joker' then
    local has_adder = SMODS.find_card("j_insc_adder")
    if #has_adder >= 0 and self.ability.insc_sold_self == nil then
        for i = 1, #has_adder do
            has_adder[i].ability.extra.destroyed_jokers = has_adder[i].ability.extra.destroyed_jokers + 1
        end
    end
  end
  return ref
end
return {name = {"BeastJokers"}, items = {adder}}