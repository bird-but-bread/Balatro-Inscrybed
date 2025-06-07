SMODS.Atlas { 
    key = "currencys",
    path = "Currencys.png",
    px = 28,
    py = 30
}

function G.UIDEF.insc_sacrifice()
    G.STATES.INSC_SACRIFICE = true
    G.insc_sacrifice_joker = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'joker', highlight_limit = 1, draw_layers = {'card'}})

    G.insc_sacrifice_playing_card = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'hand', highlight_limit = 1, draw_layers = {'card'}})

    local sacrifice_sign = AnimatedSprite(0,0, 4.4, 2.2, G.ANIMATION_ATLAS['insc_sacrifice_sign'])
    sacrifice_sign:define_draw_steps({
      {shader = 'dissolve', shadow_height = 0.05},
      {shader = 'dissolve'}
    })
    G.SACRIFICE_SIGN = UIBox{
      definition = 
        {n=G.UIT.ROOT, config = {colour = G.C.DYN_UI.MAIN, emboss = 0.05, align = 'cm', r = 0.1, padding = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0.1, minw = 4.72, minh = 3.1, colour = G.C.DYN_UI.DARK, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = sacrifice_sign}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {"Improve it's soul"}, colours = {darken(G.C.RED, 0.3)},shadow = true, rotate = true, float = true, bump = true, scale = 0.5, spacing = 1, pop_in = 1.5, maxw = 4.3})}}
            }},
          }},
        }},
      config = {
        align="cm",
        offset = {x=0,y=-15},
        major = G.HUD:get_UIE_by_ID('row_blind'),
        bond = 'Weak'
      }
    }
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = (function()
          G.SACRIFICE_SIGN.alignment.offset.y = 0
          return true
      end)
    }))
     local t = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
         {n=G.UIT.R, config={align = "cm"}, nodes={
             
            { n = G.UIT.C, config = { align = "cm", minh = 0.2 }, nodes = {
                 {
                    n = G.UIT.R,
                    config = {
                        id = 'fuse_button',
                        align = "cm",
                        minw = 2.8,
                        minh = 1.5,
                        r = 0.15,
                        colour = G.C.GREY,
                        one_press = false,
                        button = 'insc_sac_sigil',
                        hover = true,
                        shadow = true
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", maxw = 1.3 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = "Sacrifice",
                                        scale = 0.4,
                                        colour = G.C.WHITE,
                                        shadow = true
                                    }
                                }
                            }
                        }
                    }
                },
                { n = G.UIT.R, config = { align = "cm", minh = 0.2 }, nodes = {} },
                {
                    n = G.UIT.R,
                    config = {
                        id = 'next_round_button',
                        align = "lm",
                        minw = 2.8,
                        minh = 1.5,
                        r = 0.15,
                        colour = G.C.GREY,
                        one_press = true,
                        button = 'toggle_insc_sacrifice',
                        hover = true,
                        shadow = true
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = {
                                align = "cm",
                                func = 'set_button_pip'
                            },
                            nodes = {
                                {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={}},
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.3 },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Leave",
                                                scale = 0.4,
                                                colour = G.C.WHITE,
                                                shadow = true
                                            }
                                        }
                                    }
                                },
                            }
                        }
                    }
                }},
            },
            { n = G.UIT.C, config = { align = "cm", minh = 0.2 }, nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = {
                                { n = G.UIT.O, config = { object = G.insc_sacrifice_joker } }
                            }
                        }
                    }
                },
                { n = G.UIT.R, config = { align = "cm", minh = 0.2 }, nodes = {} },
                {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.1 },
                    nodes = {
                        { n = G.UIT.O, config = { object = G.insc_sacrifice_playing_card } }
                    }
                },
             }},
         }}
     }}
    return t
end

local press_amount = 0
function G.UIDEF.insc_campfire()
    G.STATES.INSC_CAMPFIRE = true
    G.insc_campfire_joker = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'joker', highlight_limit = 1, draw_layers = {'card'}})

    local sacrifice_sign = AnimatedSprite(0,0, 4.4, 2.2, G.ANIMATION_ATLAS['insc_sacrifice_sign'])
    sacrifice_sign:define_draw_steps({
      {shader = 'dissolve', shadow_height = 0.05},
      {shader = 'dissolve'}
    })
    G.SACRIFICE_SIGN = UIBox{
      definition = 
        {n=G.UIT.ROOT, config = {colour = G.C.DYN_UI.MAIN, emboss = 0.05, align = 'cm', r = 0.1, padding = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0.1, minw = 4.72, minh = 3.1, colour = G.C.DYN_UI.DARK, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = sacrifice_sign}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {"A travelers stop"}, colours = {darken(G.C.RED, 0.3)},shadow = true, rotate = true, float = true, bump = true, scale = 0.5, spacing = 1, pop_in = 1.5, maxw = 4.3})}}
            }},
          }},
        }},
      config = {
        align="cm",
        offset = {x=0,y=-15},
        major = G.HUD:get_UIE_by_ID('row_blind'),
        bond = 'Weak'
      }
    }
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = (function()
          G.SACRIFICE_SIGN.alignment.offset.y = 0
          return true
      end)
    }))
    press_amount = 0
     local t = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
         {n=G.UIT.R, config={align = "cm"}, nodes={
             
            { n = G.UIT.C, config = { align = "cm", minh = 0.2 }, nodes = {
                 press_amount<=4 and{
                    n = G.UIT.R,
                    config = {
                        id = 'heat_button',
                        align = "cm",
                        minw = 2.8,
                        minh = 1.5,
                        r = 0.15,
                        colour = HEX("a56e0e"),
                        one_press = false,
                        button = 'insc_stat_up',
                        hover = true,
                        shadow = true,
                        ref_table = press_amount
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", maxw = 1.3 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = "Heat",
                                        scale = 0.4,
                                        colour = G.C.WHITE,
                                        shadow = true
                                    }
                                }
                            }
                        }
                    }
                } or {
                    n = G.UIT.R,
                    config = {
                        id = 'heat_button',
                        align = "cm",
                        minw = 2.8,
                        minh = 1.5,
                        r = 0.15,
                        colour = HEX("72582b"),
                        hover = true,
                        shadow = true,
                        ref_table = press_amount
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", maxw = 1.3 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = "Heat",
                                        scale = 0.4,
                                        colour = G.C.WHITE,
                                        shadow = true
                                    }
                                }
                            }
                        }
                    }
                },
                { n = G.UIT.R, config = { align = "cm", minh = 0.2 }, nodes = {} },
                {n = G.UIT.R, config = {id = 'next_round_button', align = "lm", minw = 2.8, minh = 1.5, r = 0.15, colour = G.C.GREY, one_press = true, button = 'toggle_insc_campfire', hover = true, shadow = true}, nodes = {
                    {n = G.UIT.R, config = {align = "cm", func = 'set_button_pip'}, nodes = {
                        {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={}},
                        {n = G.UIT.C, config = { align = "cm", maxw = 1.3 }, nodes = {
                            {n = G.UIT.T, config = { text = "Leave", scale = 0.4, colour = G.C.WHITE, shadow = true}}}
                        },
                    }}}
                }},
            },
            { n = G.UIT.C, config = { align = "cm", minh = 0.2 }, nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = {
                                { n = G.UIT.O, config = { object = G.insc_campfire_joker } }
                            }
                        }
                    }
                },
             }},
         }}
     }}
    return t
end

function G.UIDEF.insc_scribe_select_button(card)
  return {n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
      {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.6, maxw = 1, minh = 0.3, hover = true, shadow = true, colour = G.C.PURPLE, one_press = true, button = 'insc_change_scribe'}, nodes={
        {n=G.UIT.T, config={text = "Replace",colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
      }},
  }}
end

function G.UIDEF.insc_alt_card_h_popup(card)
    if card.ability_UIBox_table then
      local AUT = card.ability_UIBox_table
      local debuffed = card.debuff
      local card_type_colour = get_type_colour(card.config.center or card.config, card)
      local card_type_background = 
          (AUT.card_type == 'Locked' and G.C.BLACK) or 
          ((AUT.card_type == 'Undiscovered') and darken(G.C.JOKER_GREY, 0.3)) or 
          (AUT.card_type == 'Enhanced' or AUT.card_type == 'Default') and darken(G.C.BLACK, 0.1) or
          (debuffed and darken(G.C.BLACK, 0.1)) or 
          (card_type_colour and darken(G.C.BLACK, 0.1)) or
          G.C.SET[AUT.card_type] or
          {0, 1, 1, 1}

      local outer_padding = 0.05
      local card_type = localize('k_'..string.lower(AUT.card_type))

      if AUT.card_type == 'Joker' or (AUT.badges and AUT.badges.force_rarity) then card_type = ({localize('k_common'), localize('k_uncommon'), localize('k_rare'), localize('k_legendary')})[card.config.center.rarity] end
      if AUT.card_type == 'Enhanced' then card_type = localize{type = 'name_text', key = card.config.center.key, set = 'Enhanced'} end
      card_type = (debuffed and AUT.card_type ~= 'Enhanced') and localize('k_debuffed') or card_type

      local disp_type, is_playing_card = 
                (AUT.card_type ~= 'Locked' and AUT.card_type ~= 'Undiscovered' and AUT.card_type ~= 'Default') or debuffed,
                AUT.card_type == 'Enhanced' or AUT.card_type == 'Default'

      local info_boxes = {}
      local badges = {}

      if AUT.badges.card_type or AUT.badges.force_rarity then
        badges[#badges + 1] = create_badge(((card.ability.name == 'Pluto' or card.ability.name == 'Ceres' or card.ability.name == 'Eris') and localize('k_dwarf_planet')) or (card.ability.name == 'Planet X' and localize('k_planet_q') or card_type),card_type_colour, nil, 1.2)
      end
      if AUT.badges then
        for k, v in ipairs(AUT.badges) do
          if v == 'negative_consumable' then v = 'negative' end
          badges[#badges + 1] = create_badge(localize(v, "labels"), get_badge_colour(v))
        end
      end

      if AUT.info then
        for k, v in ipairs(AUT.info) do
          info_boxes[#info_boxes+1] =
          {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.JOKER_GREY, 0.5), r = 0.1, padding = 0.05, emboss = 0.05}, nodes={
            info_tip_from_rows(v, v.name),
          }}
        }}
        end
      end

      return {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={align = "cm", func = 'show_infotip',object = Moveable(),ref_table = next(info_boxes) and info_boxes or nil}, nodes={
          {n=G.UIT.R, config={padding = outer_padding, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(card_type_background, 0.8)}, nodes={
              name_from_rows(AUT.name, is_playing_card and G.C.WHITE or nil),
              desc_from_rows(AUT.main),
            }}
          }}
        }},
      }}
    end
  end

  function Card:insc_alt_align_h_popup()
        local focused_ui = self.children.focused_ui and true or false
        local popup_direction = 'tm'
        return {
            major = self.children.focused_ui or self,
            parent = self,
            xy_bond = 'Strong',
            r_bond = 'Weak',
            wh_bond = 'Weak',
            offset = {
                x = popup_direction ~= 'cl' and 0 or
                    focused_ui and -0.05 or
                    (self.ability.consumeable and 0.0) or
                    (self.ability.set == 'Voucher' and 0.0) or
                    -0.05,
                y = focused_ui and (
                            popup_direction == 'tm' and (self.area and self.area == G.hand and -0.08 or-0.15) or
                            popup_direction == 'bm' and 0.12 or
                            0
                        ) or
                    popup_direction == 'tm' and -0.13 or
                    popup_direction == 'bm' and 0.1 or
                    0
            },  
            type = popup_direction,
        }
end

function G.UIDEF.insc_scribe_selection()
    G.E_MANAGER:add_event(Event({
      blockable = false,
      func = function()
        G.REFRESH_ALERTS = true
      return true
      end
    }))
    G.insc_scribe_lesh = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'shop', highlight_limit = 0, draw_layers = {'card'}})
    G.insc_scribe_po3 = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'shop', highlight_limit = 0, draw_layers = {'card'}})
    G.insc_scribe_grim = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'shop', highlight_limit = 0, draw_layers = {'card'}})
    G.insc_scribe_wiz = CardArea(
      0,
      0,
      G.CARD_W,
      G.CARD_H, 
      {card_limit = 1, type = 'shop', highlight_limit = 0, draw_layers = {'card'}})
    local t = {n=G.UIT.ROOT, config = {align = "cm", minw = G.ROOM.T.w*5, minh = G.ROOM.T.h*5,padding = 0.1, r = 0.1, colour = {G.C.GREY[1], G.C.GREY[2], G.C.GREY[3],0.7}}, nodes={
        {n=G.UIT.R, config={align = "cm", minh = 1,r = 0.3, padding = 0.07, minw = 1, colour = G.C.JOKER_GREY, emboss = 0.1}, nodes={
            {n=G.UIT.C, config={align = "cm", minh = 1,r = 0.2, padding = 0.2, minw = 1, colour =  G.C.L_BLACK}, nodes={
              {n=G.UIT.C, config={align = "cm", padding = 0.1, emboss = 0.5, r = 0.1, colour = G.C.CLEAR}, nodes={
                  {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                      {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                          {n=G.UIT.T, config={text = "One day, a challanger came to ", scale = 0.4, colour = G.C.WHITE, shadow = true}},
                      }},
                      {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                          {n=G.UIT.T, config={text = "replace one of the scrybes", scale = 0.4, colour = G.C.RED, shadow = true}}
                      }}
                  }},
                  {n=G.UIT.R, config={align = "cm", minh = 0.2}, nodes={}},
                  {n=G.UIT.R, config={align = "cm",padding = 0.1, r = 0.1, colour = lighten(G.C.GREY, 0.1)}, nodes={
                      {n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
                          { n = G.UIT.O, config = { object = G.insc_scribe_lesh }}
                      }},
                      {n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
                          { n = G.UIT.O, config = { object = G.insc_scribe_po3 }}
                      }},
                      {n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
                          { n = G.UIT.O, config = { object = G.insc_scribe_grim }}
                      }},
                      {n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
                          { n = G.UIT.O, config = { object = G.insc_scribe_wiz }}
                      }}
                  }}
              }}
            }}
        }}
    }}
    return t
end

G.FUNCS.insc_change_scribe = function(e)
    local sribe = e.parent.parent.config.parent.children.select_button.parent.children.select_button.config.scribe.scribe --why tho
    G.GAME.selected_scrybe = sribe
    if G.OVERLAY_MENU ~= nil then
        G.OVERLAY_MENU:remove()
        G.OVERLAY_MENU = nil
    end
end

G.FUNCS.insc_sac_sigil = function(e)
    if #G.insc_sacrifice_joker.cards == 1 and #G.insc_sacrifice_playing_card.cards == 1 then
        local jokerConfig = G.insc_sacrifice_joker.cards[1].ability
        if jokerConfig.insc_sacrifice_sigils ~= nil then
            if #jokerConfig.insc_sacrifice_sigils >= 1 then
                for i = 1, #jokerConfig.insc_sacrifice_sigils do
                    if jokerConfig.insc_sacrifice_sigils[i] ~= nil then
                        for j = 1, #G.jokers.cards do
                            G.jokers.cards[j]:calculate_joker({ insc_sacrificing = true })
                        end
                        G.insc_sacrifice_playing_card.cards[1]:set_sigil("insc_" .. jokerConfig.insc_sacrifice_sigils[i], nil, i == 2)
                        G.insc_sacrifice_joker.cards[1]:start_dissolve()
                        delay(0.2)
                        draw_card(G.insc_sacrifice_playing_card,G.hand, i*100/1,'up', true, G.insc_sacrifice_playing_card.cards[1])
                    end
                end
            end
        end
    end
end

G.FUNCS.insc_stat_up = function(e)
    if #G.insc_campfire_joker.cards == 1 then
        if press_amount <= 3 then
            press_amount = press_amount + 1
            if pseudorandom('campfire') < ((press_amount-1)*22.5) / 100 then
                G.insc_campfire_joker.cards[1]:start_dissolve() 
                for j = 1, #G.jokers.cards do
                    G.jokers.cards[j]:calculate_joker({ insc_by_fire_fail = true, insc_by_fire_turns = (press_amount) }) -- Contexts for fail and length of time held by fire
                end
                press_amount = 5
            else
                for j = 1, #G.jokers.cards do
                    G.jokers.cards[j]:calculate_joker({ insc_by_fire_success = true, insc_by_fire_turns = (press_amount) }) -- Contexts for success and length of time held by fire
                end
                local card = G.insc_campfire_joker.cards[1]
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "All vaules X1.5", colour = G.C.TAROT })
                insc_ability_calculate(card, "*", 1.5, { x_chips = 1, x_mult = 1, extra_value = true }, nil, true)
            end
        end
    end
end

function get_next_event_key(append)
    local _pool, _pool_key = get_current_pool('insc_Event', nil, nil, append)
    local _event = pseudorandom_element(_pool, pseudoseed(_pool_key))
    local it = 1
    while _event == 'UNAVAILABLE' do
        it = it + 1
        _event = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
    end

    return _event
end

function G.UIDEF.insc_extra_currenicies()
    local scale = 0.4
    local foil_sprite = get_foil_sprite()

    local contents = {}

    local spacing = 0.13
    local temp_col = G.C.DYN_UI.BOSS_MAIN
    contents.currenicies = {
              {n=G.UIT.C, config={align = "cm", minw = 3.3, minh = 0.7, r = 0.1, colour = G.C.DYN_UI.BOSS_DARK}, nodes={
                {n=G.UIT.O, config={w=0.5,h=0.5 , object = foil_sprite, hover = true, can_collide = false}},
                {n=G.UIT.B, config={w=0.1,h=0.1}},
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'foil'}}, maxw = 1.35, colours = {HEX("bebebe")}, font = G.LANGUAGES['en-us'].font, shadow = true,spacing = 2, bump = true, scale = 2.2*scale}), id = 'foil_text_UI'}}
              }},
              {n=G.UIT.R, config={minh = spacing},nodes={}},}
	return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
      {n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
        {n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minh = 0.3, padding = 0.08}, nodes={
          {n=G.UIT.C, config={align = "cm"}, nodes=contents.currenicies}
        }}
      }}
    }}
end


function insc_blind_extra_select(blind_choice, run_info) 
    G.GAME.round_resets.blind_events = G.GAME.round_resets.blind_events or {}
    if not G.GAME.round_resets.blind_events[blind_choice] then return nil end
    local keys = {}
    for key, _ in pairs(G.P_INSC_EVENTS) do
        table.insert(keys, key)
    end
    local randomKey = keys[math.random(1, #keys)]
    local _event = G.P_INSC_EVENTS[randomKey]
    local _event_ui, _event_sprite
    local obj = _event or {}
    if obj.generate_ui and type(obj.generate_ui) == 'function' then
        _event_ui, _event_sprite = obj:generate_ui()
    end
    _event_sprite.states.collide.can = not not run_info
    if G.GAME.round_resets.blind_states[blind_choice] == 'Select' then 
        return {n=G.UIT.R, config={id = 'insc_event_container', ref_table = {_event, blind_choice, run_info}, align = "cm"}, nodes={
            {n=G.UIT.R, config={id = 'event_'..blind_choice, align = "cm", r = 0.1, padding = 0.1, minw = 1, can_collide = true, ref_table = _event_sprite}, nodes={
                {n=G.UIT.C, config={id = 'insc_event_desc', align = "cm", minh = 1}, nodes={
                  _event_ui
                }},
                (_event.disabled and not run_info) and {n=G.UIT.C, config={align = "cm", colour = G.C.UI.BACKGROUND_INACTIVE, minh = 0.6, minw = 2, maxw = 2, padding = 0.07, r = 0.1, shadow = true, hover = true, one_press = true, button = 'insc_event_start', func = 'hover_tag_proxy', ref_table = _event}, nodes={
                  {n=G.UIT.T, config={text = "Engage", scale = 0.4, colour = G.C.UI.INACTIVE}}
                }} or {n=G.UIT.C, config={align = "cm", padding = 0.1, emboss = 0.05, colour = mix_colours(G.C.UI.BACKGROUND_INACTIVE, G.C.BLACK, 0.4), r = 0.1, maxw = 2}, nodes={
                  {n=G.UIT.T, config={text = "Locked", scale = 0.35, colour = G.C.WHITE}},
                }},
            }},
        }}
    end
end

function ease_foil(mod, instant)
    local function _mod(mod)
        mod = mod or 0
        local text = '+'..localize('#')
        local col = G.C.MONEY
        if mod < 0 then
            text = '-'..localize('#')
            col = G.C.RED              
        end
        --Ease from current chips to the new number of chips
        G.GAME.foil = G.GAME.foil + mod
        play_sound('coin1')
    end
    if instant then
        _mod(mod)
    else
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            _mod(mod)
            return true
        end
        }))
    end
end

function get_foil_sprite( _scale, disabled)
  if disabled == nil then
      disabled = false
  end
  _scale = _scale or 1
  local foil_sprite = Sprite(0,0,_scale*1,_scale*1,G.ASSET_ATLAS["insc_currencys"], {x=0,y=0})
  if disabled then
    foil_sprite = Sprite(0,0,_scale*1,_scale*1,G.ASSET_ATLAS["insc_currencys"], {x=1,y=0})
  end
  foil_sprite.states.drag.can = false
  return foil_sprite
end

function calculate_booster_reroll_cost(skip_increment)
    if G.GAME.current_round.free_rerolls < 0 then G.GAME.current_round.free_rerolls = 0 end
    if G.GAME.current_round.free_rerolls > 0 then G.GAME.current_round.reroll_foil_cost = 0; return end
    G.GAME.current_round.reroll_foil_cost_increase = G.GAME.current_round.reroll_foil_cost_increase or 0
    if not skip_increment then G.GAME.current_round.reroll_foil_cost_increase = G.GAME.current_round.reroll_foil_cost_increase + 1 end
    G.GAME.current_round.reroll_foil_cost = (G.GAME.round_resets.reroll_foil_cost) + G.GAME.current_round.reroll_foil_cost_increase
end

 G.FUNCS.reroll_booster_shop = function(e) 
    stop_use()
    G.CONTROLLER.locks.shop_reroll = true
    if G.CONTROLLER:save_cardarea_focus('shop_booster') then G.CONTROLLER.interrupt.focus = true end
    if G.GAME.current_round.reroll_foil_cost > 0 then 
      ease_foil(-G.GAME.current_round.reroll_foil_cost)
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          local final_free = G.GAME.current_round.free_rerolls > 0
          G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls - 1, 0)
          G.GAME.round_scores.times_rerolled.amt = G.GAME.round_scores.times_rerolled.amt + 1

          calculate_booster_reroll_cost(final_free)
          for i = #G.shop_booster.cards,1, -1 do
            local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
            c:remove()
            c = nil
          end

          --save_run()

          play_sound('coin2')
          play_sound('other1')
          
          for i = 1, G.GAME.shop.joker_max - #G.shop_booster.cards do
            local new_shop_card = create_card_for_shop(G.shop_booster)
            G.shop_booster:emplace(new_shop_card)
            new_shop_card:juice_up()
          end
          return true
        end
      }))
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = function()
        G.E_MANAGER:add_event(Event({
          func = function()
            G.CONTROLLER.interrupt.focus = false
            G.CONTROLLER.locks.shop_reroll = false
            G.CONTROLLER:recall_cardarea_focus('shop_booster')
            for i = 1, #G.jokers.cards do
              G.jokers.cards[i]:calculate_joker({reroll_shop = true})
            end
            return true
          end
        }))
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
  end

  G.FUNCS.can_reroll_boosters = function(e)
    if ((G.GAME.foil-G.GAME.bankrupt_foil_at) - G.GAME.current_round.reroll_foil_cost < 0) and G.GAME.current_round.reroll_foil_cost ~= 0 then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.children[1].children[2].children[1].config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.BLUE
        e.children[1].children[2].children[1].config.colour = G.C.WHITE
        e.config.button = 'reroll_booster_shop'
    end
  end

G.FUNCS.insc_event_start = function(e)
    local _event = e.UIBox:get_UIE_by_ID('insc_event_container').config.ref_table[1]
    local blind_choice = e.UIBox:get_UIE_by_ID('insc_event_container').config.ref_table[2]
    G.GAME.round_resets.blind_event_visablity[blind_choice] = false
    if _event.key == "ev_insc_sacrifice" then
        stop_use()
        if G.blind_select then 
            G.GAME.facing_blind = true
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object.pop_delay = 0
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object:pop_out(5)
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object.pop_delay = 0
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object:pop_out(5) 

            G.E_MANAGER:add_event(Event({
              trigger = 'before', delay = 0.2,
              func = function()
                G.blind_prompt_box.alignment.offset.y = -10
                G.blind_select.alignment.offset.y = 40
                G.blind_select.alignment.offset.x = 0
                return true
            end}))
            G.E_MANAGER:add_event(Event({
              trigger = 'immediate',
              func = function()
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.blind_select = nil
                delay(0.2)
                return true
            end}))
        end
        G.STATES.INSC_SACRIFICE = 20
        G.STATE = G.STATES.INSC_SACRIFICE
        delay(0.2)
        G.GAME.round_resets.event_state.State = "Sacrifice"
        G.FUNCS.draw_from_deck_to_hand()
        G.insc_sacrifice = UIBox{
            definition = G.UIDEF.insc_sacrifice(),
            config = {align='tmi', offset = {x=0,y=29},major = G.hand, bond = 'Weak'}
        }
        G.insc_sacrifice:draw()
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
              G.insc_sacrifice.alignment.offset.y = -6.35
              return true
            end
          })) 
    elseif _event.key == "ev_insc_campfire" then
        if G.blind_select then 
            G.GAME.facing_blind = true
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object.pop_delay = 0
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object:pop_out(5)
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object.pop_delay = 0
            G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object:pop_out(5) 

            G.E_MANAGER:add_event(Event({
              trigger = 'before', delay = 0.2,
              func = function()
                G.blind_prompt_box.alignment.offset.y = -10
                G.blind_select.alignment.offset.y = 40
                G.blind_select.alignment.offset.x = 0
                return true
            end}))
            G.E_MANAGER:add_event(Event({
              trigger = 'immediate',
              func = function()
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.blind_select = nil
                delay(0.2)
                return true
            end}))
        end
        G.STATES.INSC_CAMPFIRE = 21
        G.STATE = G.STATES.INSC_CAMPFIRE
        delay(0.2)
        G.GAME.round_resets.event_state.State = "Campfire"
        G.insc_campfire = UIBox{
            definition = G.UIDEF.insc_campfire(),
            config = {align='tmi', offset = {x=0,y=29},major = G.hand, bond = 'Weak'}
        }
        G.insc_campfire:draw()
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
              G.insc_campfire.alignment.offset.y = -4.85
              return true
            end
          })) 
    end
end

G.FUNCS.toggle_insc_sacrifice = function(e)
    stop_use()
    G.GAME.round_resets.event_state.State = ""
    G.CONTROLLER.locks.toggle_insc_sacrifice = true
    if G.insc_sacrifice then 
      if G.insc_sacrifice_playing_card.cards[1] ~= nil then
        draw_card(G.insc_sacrifice_playing_card,G.hand, 100/1,'up', true, G.insc_sacrifice_playing_card.cards[1])
      end
      if G.insc_sacrifice_joker.cards[1] ~= nil then
        draw_card(G.insc_sacrifice_joker,G.jokers, 100/1,'up', true, G.insc_sacrifice_joker.cards[1])
      end
      for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:calculate_joker({ending_insc_sacrifice = true}) -- New context.ending_insc_sacrifice
      end
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.insc_sacrifice.alignment.offset.y = G.ROOM.T.y + 29
          G.SACRIFICE_SIGN.alignment.offset.y = -15
          return true
        end
      })) 
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
          G.FUNCS.draw_from_hand_to_deck()
          G.insc_sacrifice:remove()
          G.insc_sacrifice = nil
          G.SACRIFICE_SIGN:remove()
          G.SACRIFICE_SIGN = nil
          G.STATE_COMPLETE = false
          G.STATE = G.STATES.BLIND_SELECT
          if G.GAME.round_resets.blind_states.Boss == 'Defeated' then 
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.ante
            G.GAME.round_resets.blind_tags.Small = get_next_tag_key()
            G.GAME.round_resets.blind_tags.Big = get_next_tag_key()
          end
          G.CONTROLLER.locks.toggle_insc_sacrifice = nil
          return true
        end
      }))
    end
  end

G.FUNCS.toggle_insc_campfire = function(e)
    stop_use()
    G.GAME.round_resets.event_state.State = ""
    G.CONTROLLER.locks.toggle_insc_campfire = true
    if G.insc_campfire then 
      if G.insc_campfire_joker.cards[1] ~= nil then
        draw_card(G.insc_campfire_joker,G.jokers, 100/1,'up', true, G.insc_campfire_joker.cards[1])
      end
      for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:calculate_joker({ending_insc_campfire = true}) -- New context.ending_insc_campfire
      end
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.insc_campfire.alignment.offset.y = G.ROOM.T.y + 29
          G.SACRIFICE_SIGN.alignment.offset.y = -15
          return true
        end
      })) 
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
          G.FUNCS.draw_from_hand_to_deck()
          G.insc_campfire:remove()
          G.insc_campfire = nil
          G.SACRIFICE_SIGN:remove()
          G.SACRIFICE_SIGN = nil
          G.STATE_COMPLETE = false
          G.STATE = G.STATES.BLIND_SELECT
          if G.GAME.round_resets.blind_states.Boss == 'Defeated' then 
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.ante
            G.GAME.round_resets.blind_tags.Small = get_next_tag_key()
            G.GAME.round_resets.blind_tags.Big = get_next_tag_key()
          end
          G.CONTROLLER.locks.toggle_insc_campfire = nil
          return true
        end
      }))
    end
  end