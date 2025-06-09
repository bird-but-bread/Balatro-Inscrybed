local start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
  local ref = start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
  if G.jokers and self.ability.set == 'Joker' then
    SMODS.calculate_context({
      insc_destroying_or_selling_joker = true,
      insc_destroyed_joker = self
    })
    if self.ability.insc_sold_self == nil then
      SMODS.calculate_context({
      insc_destroying_joker = true,
      insc_destroyed_joker = self
     })
    end
  end
end