-- sigil collection UI stuff
SMODS.current_mod.custom_collection_tabs = function()
	return { UIBox_button {
        count = G.ACTIVE_MOD_UI and modsCollectionTally(G.P_CENTER_POOLS["Sigil"]),
        button = 'your_collection_sigil',
        label = {"Sigils"}, minw = 5, id = 'your_collection_sigil'
    }}
end

G.FUNCS.your_collection_sigil = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_your_collection_sigil(),
    }
end

create_UIBox_your_collection_sigil = function()
    return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Sigil, {5,5}, {
        snap_back = true,
        infotip = localize('ml_edition_sigil_enhancement_explanation'),
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.03,
        modify_card = function(card, center)
            card:set_sigil(center.key, 1)
        end,
    })
end

function Card:get_sigil(index)
	if self.sigil == nil then
        return false
    end
    if self.sigil[index] ~= nil then
        return self.sigil[index]
    end
    return false
end

function create_consumable(card_type,tag,message,extra, thing1, thing2)
    extra=extra or {}
    
    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type,G.consumeables, nil, nil, thing1, thing2, extra.forced_key or nil, tag)
                card:add_to_deck()
                if extra.edition~=nil then
                    card:set_edition(extra.edition,true,false)
                end
                if extra.eternal~=nil then
                    card.ability.eternal=extra.eternal
                end
                if extra.perishable~=nil then
                    card.ability.perishable = extra.perishable
                    if tag=='v_epilogue' then
                        card.ability.perish_tally=get_voucher('epilogue').config.extra
                    else card.ability.perish_tally = G.GAME.perishable_rounds
                    end
                end
                if extra.extra_ability~=nil then
                    card.ability[extra.extra_ability]=true
                end
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                if message~=nil then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=message})
                end
        return true
    end)}))
end

function create_joker(card_type,tag,message,extra, rarity)
    extra=extra or {}
    
    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type, G.joker, nil, rarity, nil, nil, extra.forced_key or nil, tag)
                card:add_to_deck()
                if extra.edition~=nil then
                    card:set_edition(extra.edition,true,false)
                end
                if extra.eternal~=nil then
                    card.ability.eternal=extra.eternal
                end
                if extra.perishable~=nil then
                    card.ability.perishable = extra.perishable
                    if tag=='v_epilogue' then
                        card.ability.perish_tally=get_voucher('epilogue').config.extra
                    else card.ability.perish_tally = G.GAME.perishable_rounds
                    end
                end
                if extra.extra_ability~=nil then
                    card.ability[extra.extra_ability]=true
                end
                G.jokers:emplace(card)
                G.GAME.joker_buffer = 0
                if message~=nil then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=message})
                end
        return true
    end)}))
end

insc_ability_calculate = function(card, equation, extra_value, exclusions, inclusions, do_round, only, extra_search)
  if do_round == nil then do_round = true end
  if only == nil then only = false end

  local operators = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end,
    ["%"] = function(a, b) return a % b end,
    ["="] = function(a, b) return b end,
  }
  
  local function round_int(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
  end

  local function round_hundredth(x)
    if x >= 0 then
      return math.floor(x * 100 + 0.5) / 100
    else
      return math.ceil(x * 100 - 0.5) / 100
    end
  end

  local function process_value(val)
    if type(val) == "number" then
      local res = operators[equation](val, extra_value)
      if do_round then
        if val % 1 ~= 0 then
          return round_hundredth(res)
        else
          return round_int(res)
        end
      else
        return res
      end
    else
      return val
    end
  end

  local function should_process(key, value)
    if type(key) ~= "string" then return true end
    if inclusions and next(inclusions) then
      local valid = false
      for _, prefix in ipairs(inclusions) do
        if (not only and key:sub(1, #prefix) == prefix) or (only and key == prefix) then
          valid = true; break
        end
      end
      if not valid then return false end
    end
    if exclusions and exclusions[key] ~= nil then
      if exclusions[key] == true or value == exclusions[key] then
        return false
      end
    end
    return true
  end

  local function process_table(t)
    for key, value in pairs(t) do
      if value ~= nil and should_process(key, value) then
        if type(value) == "number" then
          t[key] = process_value(value)
        elseif type(value) == "table" then
          process_table(value)
        end
      end
    end
  end

  local search_table = extra_search and card[extra_search] or card.ability

  if search_table then
    if type(search_table) == "number" then
      search_table = process_value(search_table)
    elseif type(search_table) == "table" then
      process_table(search_table)
    end
  end
end


insc_ability_get_items = function(card, equation, extra_value, exclusions, inclusions, do_round, only, extra_search)
  if do_round == nil then do_round = true end
  if only == nil then only = false end

  local keys = {}
  local values = {}

  local operators = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end,
    ["%"] = function(a, b) return a % b end,
    ["="] = function(a, b) return b end,
    ["nil"] = function(a, b) return a end,
  }

  local function round_int(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
  end
  local function round_hundredth(x)
    if x >= 0 then
      return math.floor(x * 100 + 0.5) / 100
    else
      return math.ceil(x * 100 - 0.5) / 100
    end
  end

  local function process_value(val)
    if type(val) == "number" then
      local res = operators[equation](val, extra_value)
      if do_round then
        if val % 1 ~= 0 then
          return round_hundredth(res)
        else
          return round_int(res)
        end
      else
        return res
      end
    else
      return val
    end
  end

  local function should_process(key, value)
    if type(key) ~= "string" then return true end
    if inclusions and next(inclusions) then
      local valid = false
      for _, prefix in ipairs(inclusions) do
        if (not only and key:sub(1, #prefix) == prefix) or (only and key == prefix) then
          valid = true; break
        end
      end
      if not valid then return false end
    end
    if exclusions and exclusions[key] ~= nil then
      if exclusions[key] == true or value == exclusions[key] then
        return false
      end
    end
    return true
  end

  local search_table = extra_search and card[extra_search] or card.ability

  if search_table then
    if type(search_table) == "number" then
      table.insert(keys, extra_search or "ability")
      table.insert(values, process_value(search_table))
    elseif type(search_table) == "table" then
      for key, value in pairs(search_table) do
        if value ~= nil and should_process(key, value) then
          table.insert(keys, key)
          table.insert(values, process_value(value))
        end
      end
    end
  end

  return keys, values
end

function toNum(big)
    big = tostring(big)
    big = big:gsub(",", "")
  return tonumber(big) or 0
end

function insc_add_custom_round_eval_row(name, foot, intrest, the_colour, sprite)
    the_colour = the_colour or HEX("bebebe")
    local width = G.round_eval.T.w - 0.51
    local scale = 0.9
    total_cashout_rows = (total_cashout_rows or 0) + 1
    delay(0.4)
    local rand = math.floor(math.random() * 100)
    if sprite == nil then
        sprite = false
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'before',delay = 0.5,
        func = function()
            local left_text = {}
            if intrest then
                table.insert(left_text, {n=G.UIT.T, config={text = intrest, scale = 0.8*scale, colour = the_colour, shadow = true, juice = true}})
            end
            if intrest then
                table.insert(left_text, {n=G.UIT.O, config={object = DynaText({string = name, colours = {G.C.UI.TEXT_LIGHT}, shadow = true, pop_in = 0, scale = 0.4*scale, silent = true})}})
            else
                table.insert(left_text, {n=G.UIT.O, config={object = DynaText({string = name, colours = {the_colour}, shadow = true, pop_in = 0, scale = 0.6*scale, silent = true})}})
            end
            local full_row = {n=G.UIT.R, config={align = "cm", minw = 5}, nodes={
                {n=G.UIT.C, config={padding = 0.05, minw = width*0.55, minh = 0.61, align = "cl"}, nodes=left_text},
                {n=G.UIT.C, config={padding = 0.05,minw = width*0.45, align = "cr"}, nodes={{n=G.UIT.C, config={align = "cm", id = 'dollar_insc_'..name .. tostring(total_cashout_rows).. tostring(rand)},nodes={}}}}
            }}
            G.round_eval:add_child(full_row,G.round_eval:get_UIE_by_ID('bonus_round_eval'))
            play_sound('cancel', 1)
            play_sound('highlight1', 1, 0.2)
            return true
        end
    }))
    if not sprite then
        G.E_MANAGER:add_event(Event({
            trigger = 'before',delay = 0.38,
            func = function()
                    G.round_eval:add_child(
                            {n=G.UIT.R, config={align = "cm", id = 'dollar_row_insc_'..name .. tostring(total_cashout_rows).. tostring(rand)}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {foot}, colours = {the_colour}, shadow = true, pop_in = 0, scale = 0.65, float = true})}}
                            }},
                            G.round_eval:get_UIE_by_ID('dollar_insc_'..name .. tostring(total_cashout_rows).. tostring(rand)))
                play_sound('coin3', 0.9+0.2*math.random(), 0.7)
                play_sound('coin6', 1.3, 0.8)
                return true
            end
        }))
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'before',delay = 0.38,
            func = function()
                    G.round_eval:add_child(
                            {n=G.UIT.R, config={align = "cm", id = 'dollar_row_insc_'..name .. tostring(total_cashout_rows).. tostring(rand)}, nodes={
                                {n=G.UIT.O, config={w=0.5,h=0.5 , object = sprite, hover = true, can_collide = false}},
                                {n=G.UIT.O, config={object = DynaText({string = {foot}, colours = {the_colour}, shadow = true, pop_in = 0, scale = 0.65, float = true})}},
                            }},
                            G.round_eval:get_UIE_by_ID('dollar_insc_'..name .. tostring(total_cashout_rows).. tostring(rand)))
                play_sound('coin3', 0.9+0.2*math.random(), 0.7)
                play_sound('coin6', 1.3, 0.8)
                return true
            end
        }))
    end
end

function UIBox:get_UIE_by_button(name)
  for _, uie in ipairs(self.nodes) do
    if uie.config and uie.config.button == name then
      return uie
    end
  end
end

function UIBox:get_UIE_by_func(fn_name)
  for _, uie in ipairs(self.nodes) do
    if uie.config and uie.config.func == fn_name then
      return uie
    end
  end
end


local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front);
    if _center and _center.insc_num_layer then
        if _center then
            self.children.insc_floating_sprite_num = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.insc_num_layer)
            self.children.insc_floating_sprite_num.role.draw_major = self
            self.children.insc_floating_sprite_num.states.hover.can = false
            self.children.insc_floating_sprite_num.states.click.can = false
        end
    end
end
SMODS.draw_ignore_keys.insc_floating_sprite_num = true

-- Death card stuff
Deathcard.create_UIBox_select_summon_materials = function(card)

    local amount = #G.jokers.cards + 1
    BalatroInscrybed.death_card_area = CardArea(0, 10, G.CARD_W, G.CARD_H*3.4, 
    {card_limit = 1, type = 'title', highlight_limit = 1})
    BalatroInscrybed.chose_card_one = CardArea(0, 0, G.CARD_W, G.CARD_H*1, 
    {card_limit = amount, type = 'title', highlight_limit = 1})


    return {
        n = G.UIT.ROOT, config = {align = "cm", minw = G.ROOM.T.w * 5, minh = G.ROOM.T.h * 5, padding = 0, r = 0.1, colour = HEX("3F4A61")}, nodes = {
            {n=G.UIT.R, config={align = "tm"},nodes={
                {n=G.UIT.C, config={align = "tm", padding    =-.5},nodes={
                    {n=G.UIT.O, config = {object = Sprite(0, 0, 12, 12, G.ASSET_ATLAS['insc_dcc'], {x=0,y=0}), hover = true, can_collide = false}},
                }},
                {n=G.UIT.C, config={align = "tm", padding =-.5},nodes={
                    {n=G.UIT.O, config = {object = BalatroInscrybed.death_card_area, hover = true, can_collide = false}},
                }},     
                {n=G.UIT.C, config={align = "tm", padding =-.5},nodes={ 
                    {n=G.UIT.O, config = {object = Sprite(0, 0, 12, 12, G.ASSET_ATLAS['insc_dcc'], {x=1,y=0}), hover = true, can_collide = false}}, 
                }},             
            }},
            {n=G.UIT.R, config={align = "bm", padding = 0,  minh=4,},nodes={
                {n=G.UIT.O, config = {object = BalatroInscrybed.chose_card_one, hover = true, can_collide = false}},
            }},

        },}
end

G.FUNCS.death_card_start = function(e)
    G.OVERLAY_MENU:remove()
    G.OVERLAY_MENU = nil
    G.FUNCS.overlay_menu({
            definition = Deathcard.create_UIBox_select_summon_materials(card)
        })
    SMODS.add_card{
        key = "j_insc_deathcard",
        area = BalatroInscrybed.death_card_area
    }
    
    local jokers = {}
    for i = #G.jokers.cards, 1, -1 do
        local card_ = G.jokers.cards[i]
        table.insert(jokers, card_)
        G.jokers:remove_card(card_)
        BalatroInscrybed.chose_card_one:emplace(card_)
    end
    SMODS.add_card{
        key = "j_insc_deathcard",
        BalatroInscrybed.chose_card_one
    } 
end

