local black_goat = {
    object_type = "Joker",
    name = "Black Goat",
    key = "black_goat",
    insc_type = "Hooved",
    pos = { x = 0, y = 2 },
    config = { insc_sacrifice_sigils = {"sacrifice"}, extra = { has_triggered = false }},
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
        if context.insc_destroying_or_selling_joker and context.cardarea == G.jokers then
          if not card.ability.extra.has_triggered then
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_again_ex') })
            card.ability.extra.has_triggered = true
          elseif card.ability.extra.has_triggered then
            card.ability.extra.has_triggered = false
          end
        end
    end,
}
local sell_card_ref = Card.sell_card
function Card:sell_card()
  local ref = sell_card_ref(self)
  if self.config.center_key == "j_insc_black_goat" and self.ability.insc_sold_self ~= 2 then
    self.ability.insc_sold_self = self.ability.insc_sold_self or 0
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 1.0,
        func = function()
          local card = copy_card(self, nil, nil, nil, false)
          card:start_materialize()
          card:add_to_deck()
          card.ability.insc_sold_self = self.ability.insc_sold_self
          G.jokers:emplace(card)
          G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 1.0,
            func = function()
              card:sell_card()
              return true
            end
          }))
          return true
        end
    }))
    self.ability.insc_sold_self = self.ability.insc_sold_self + 1
  elseif self.config.center_key ~= "j_insc_black_goat" then
    self.ability.insc_sold_self = true
  end
  return ref
end

local start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
  local ref = start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
  if G.jokers and self.ability.set == 'Joker' then
    if self.config.center_key == "j_insc_black_goat" and (self.ability.has_black_goat_triggered == nil or self.ability.has_black_goat_triggered ~= 2) and not self.ability.insc_sold_self then
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 1.0,
        func = function()
          local card = copy_card(self, nil, nil, nil, false)
          card:start_materialize()
          card:add_to_deck()
          card.ability.has_black_goat_triggered = self.ability.has_black_goat_triggered or 0
          card.ability.has_black_goat_triggered = card.ability.has_black_goat_triggered + 1
          card.getting_sliced = false
          G.jokers:emplace(card)
          card.ability.insc_sold_self = nil
          G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 1.0,
            func = function()
              card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
              return true
            end
          }))
          return true
        end
      }))
    end
  end
  return ref
end
return {name = {"BeastJokers"}, items = {black_goat}}