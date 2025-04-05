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
                        button = 'toggle_insc_campfire',
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
                                    n = G.UIT.C,
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
                insc_ability_calculate(card, "*", 1.5, nil, nil, true)
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
            config = {align='tmi', offset = {x=0,y=-6.35},major = G.hand, bond = 'Weak'}
        }
        G.insc_sacrifice:draw()
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
            config = {align='tmi', offset = {x=0,y=-4.85},major = G.hand, bond = 'Weak'}
        }
        G.insc_campfire:draw()
    end
end

G.FUNCS.toggle_insc_sacrifice = function(e)
    stop_use()
    G.GAME.round_resets.event_state.State = ""
    G.CONTROLLER.locks.toggle_insc_sacrifice = true
    if G.insc_sacrifice then 
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