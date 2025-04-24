BalatroInscrybed.Sigil = SMODS.GameObject:extend {
    obj_table = BalatroInscrybed.Sigils,
    obj_buffer = {},
    rng_buffer = {},
    badge_to_key = {},
    set = 'Sigil',
    atlas = 'centers',
    atlas_extra = 'centers',
    pos = { x = 0, y = 0 },
    discovered = false,
    badge_colour = HEX('FFFFFF'),
    required_params = {
        'key',
        'pos',
    },
    inject = function(self)
        G.P_SIGILS[self.key] = self
        G.shared_sigils[self.key] = Sprite(0, 0, G.CARD_W, G.CARD_H,
            G.ASSET_ATLAS[self.atlas] or G.ASSET_ATLAS['centers'], self.pos)
        G.shared_sigils2[self.key] = Sprite(0, 0, G.CARD_W, G.CARD_H,
            G.ASSET_ATLAS["insc_"..self.atlas_extra] or G.ASSET_ATLAS['centers'], self.pos)
        self.badge_to_key[self.key:lower() .. '_sigil'] = self.key
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
        self.rng_buffer[#self.rng_buffer + 1] = self.key
    end,
    get_obj = function(self, key) return G.P_SIGILS[key] end,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        local target = {
            type = 'other',
            set = 'Other',
            key = self.key:lower()..'_sigil',
            nodes = desc_nodes,
            vars = specific_vars or {},
        }
        local res = {}
        if self.loc_vars and type(self.loc_vars) == 'function' then
            res = self:loc_vars(info_queue, card) or {}
            target.vars = res.vars or target.vars
            target.key = res.key or target.key
            if res.set then
                target.type = 'descriptions'
                target.set = res.set
            end
            target.scale = res.scale
            target.text_colour = res.text_colour
        end
        if desc_nodes == full_UI_table.main and not full_UI_table.name then
            full_UI_table.name = localize { type = 'name', set = target.set, key = res.name_key or target.key, nodes = full_UI_table.name, vars = res.name_vars or target.vars or {} }
        elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name then
            desc_nodes.name = localize{type = 'name_text', key = res.name_key or target.key, set = target.set }
        end
        if res.main_start then
            desc_nodes[#desc_nodes + 1] = res.main_start
        end
        localize(target)
        if res.main_end then
            desc_nodes[#desc_nodes + 1] = res.main_end
        end
        desc_nodes.background_colour = res.background_colour
    end,
        
}

--Sigils

--fecundity 
BalatroInscrybed.Sigil { 
    name = "insc_fecundity",
    key = "fecundity",
    badge_colour = HEX("9fff80"),
    config = { odds = 4 },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=3, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, self.config.odds } }--might be center.config.odds
    end,
    -- consider changing the functionality to only add to hand and not to deck permenantly
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('rat_test') < G.GAME.probabilities.normal/self.config.odds then -- tell me if this breaks because why make it hard coded? -smg9000
                --this code is just stolen from DNA
                local card = copy_card(card, nil, nil, G.playing_card)
                card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card)
                G.hand:emplace(card)
                card.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_materialize()
                        return true end,
                }))
                return{
                    message = {
                        "Infested!",
                    }
                }
            else
                return{
                    message = {"Aw, rats!"}
                }
            end
        end
    end
}

--Trinket Bearer 
BalatroInscrybed.Sigil { 
    name = "insc_Trinket_Bearer",
    key = "trinket",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local _card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, nil, 'trinket')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card:juice_up(0.3, 0.5)
                end
                return true end }))
            delay(0.6)
        end
    end
}

--Brittle
BalatroInscrybed.Sigil { 
    name = "insc_Brittle",
    key = "brittle",
    badge_colour = HEX("9fff80"),
    config = { odds = 4, chips = 100 },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=5},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds, card.ability.sigil[index].chips } }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            SMODS.calculate_effect({chip_mod = card.ability.sigil[index].chips, message = localize{type='variable',key='a_chips',vars={card.ability.sigil[index].chips}}}, card)
        end
        if context.final_scoring_step and context.cardarea == G.play then
            if pseudorandom('brittle') < G.GAME.probabilities.normal/card.ability.sigil[index].odds then
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function() 
                    card:shatter()
                    return true end }))
            end
        end
    end,
}

--Bone King
BalatroInscrybed.Sigil { 
    name = "insc_Bone_King",
    key = "bone_king",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            for i = 1,#context.hand_drawn do
                if context.hand_drawn[i] == card then
                    ease_discard(1)
                end
            end
        end
    end
}

--Leader
BalatroInscrybed.Sigil { 
    name = "insc_Leader",
    key = "leader",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then
                    if #G.play.cards == 1 then
                        return
                    elseif i == 1 then
						G.play.cards[i+1].ability.perma_mult = G.play.cards[i+1].ability.perma_mult + 5
                    elseif i == #G.play.cards then
						G.play.cards[i-1].ability.perma_mult = G.play.cards[i-1].ability.perma_mult + 5
                    else
                        local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                        for j = 1, #cards do
                            cards[j].ability.perma_mult = cards[j].ability.perma_mult + 5
                        end
                    end
                end
            end
        end
    end,
}

--Hostage File
BalatroInscrybed.Sigil { 
    name = "insc_Hostage_File",
    key = "hostage_file",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    if #G.jokers.cards >= 1 then
                        local money = G.jokers.cards[1].cost
                        G.jokers.cards[1]:start_dissolve()
                        return{
                            dollars = money
                        }
                    end
                end
            end
        end
    end
}

--Dam Builder
BalatroInscrybed.Sigil { 
    name = "insc_Dam_Builder",
    key = "dam_builder",
    badge_colour = HEX("9fff80"),
    config = { trigger = true },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=1, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.before and context.cardarea == G.play and card.ability.sigil[index].trigger then
            local _card = copy_card(card, nil, nil, G.playing_card)
            _card:set_ability(G.P_CENTERS.m_stone, nil)
            _card.ability.sigil_destroy_self = true
            _card:set_seal()
            _card:set_sigil(nil, 1)
            _card:set_sigil(nil, 2)
            table.insert(context.scoring_hand, _card)
            G.play:emplace(_card)
            _card:highlight(true)
            local _card_ = copy_card(card, nil, nil, G.playing_card)
            _card_:set_ability(G.P_CENTERS.m_stone, nil)
            _card_.ability.sigil_destroy_self = true
            _card_:set_seal()
            _card_:set_sigil(nil, 1)
            _card_:set_sigil(nil, 2)
            table.insert(context.scoring_hand, _card_)
            G.play:emplace(_card_)
            _card_:highlight(true)
        end
        if context.hand_drawn then
            card.ability.sigil[index].trigger = true
        end
    end
}

--Repulsive 
BalatroInscrybed.Sigil { 
    name = "insc_Repulsive",
    key = "repulsive",
    badge_colour = HEX("9fff80"),
    config = { trigger = false, card = nil },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and context.cardarea == G.hand and (self.config.trigger == false or self.config.trigger == "nil") then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if (G.hand.cards[i].sigil[1] ~= nil and G.hand.cards[i].sigil[1] == self.key) or (G.hand.cards[i].sigil[2] ~= nil and G.hand.cards[i].sigil[2] == self.key) then
                        self.config.trigger = true
                        return
                    end
                end
            end
        end
        if self.config.trigger ~= "nil" then
            if context.before and context.cardarea == G.play and self.config.trigger then
                for i = 1, #G.play.cards do
                    if G.play.cards[i].sigil ~= nil then
                        if (G.play.cards[i].sigil[1] ~= nil and G.play.cards[i].sigil[1] == self.key) or (G.play.cards[i].sigil[2] ~= nil and G.play.cards[i].sigil[2] == self.key) then
                            self.config.trigger = false
                            return
                        end
                    end
                end
            end
            if context.remove_playing_cards and context.removed and self.config.trigger then
                for i = 1, #context.removed do
                    if context.removed[i].sigil ~= nil then
                        if (context.removed[i].sigil[1] ~= nil and context.removed[i].sigil[1] == self.key) or (context.removed[i].sigil[2] ~= nil and context.removed[i].sigil[2] == self.key) then
                            self.config.trigger = false
                            return
                        end
                    end
                end
            end
            if context.discard and self.config.trigger then
                for i = 1, #G.hand.highlighted do
                    if G.hand.highlighted[i].sigil ~= nil then
                        if (G.hand.highlighted[i].sigil[1] ~= nil and G.hand.highlighted[i].sigil[1] == self.key) or (G.hand.highlighted[i].sigil[2] ~= nil and G.hand.highlighted[i].sigil[2] == self.key) then
                            self.config.trigger = false
                            return
                        end
                    end
                end
            end
        end
    end,
    update = function(self, card, dt)
        if self.config.trigger ~= "nil" then
            if self.config.trigger then
                if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                    G.GAME.blind:disable()
                end
            elseif not self.config.trigger then
                if G.GAME.blind and ((G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                    local blind = G.GAME.blind
                    blind.disabled = false
                    G.GAME.blind:set_blind(blind, true, true)
                    G.GAME.blind:set_text()
                    self.config.trigger = "nil"
                end
            end
        end
    end
}

--Kraken Waterborne
BalatroInscrybed.Sigil { 
    name = "insc_Kraken_Waterborne",
    key = "kraken_waterborne",
    badge_colour = HEX("9fff80"),
    config = {tentacle = 0},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=7},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].tentacle} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            local index = nil
            if card.sigil ~= nil then
                if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                    index = 1
                elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                    index = 2
                end
            end
            local retriggers = 0
            for i = 1, card.ability.sigil[index].tentacle do
                retriggers = retriggers + 1
            end
            if retriggers > 0 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = retriggers,
                    card = card
                }
            end
        end
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        card.ability.sigil[index].tentacle = 0
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.hand.cards[i].ability.sigil[1].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.hand.cards[i].ability.sigil[2].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                    end
                end
            end
        end
        if G.play ~= nil then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.play.cards[i].ability.sigil[1].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.play.cards[i].ability.sigil[2].tentacle then
                                card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                            end
                        end
                    end
                end
            end
        end
        if G.jokers ~= nil then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.insc_tentacle_trigger ~= nil and G.jokers.cards[i].ability.insc_tentacle_trigger then
                    card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                end
                if G.jokers.cards[i].ability.extra ~= nil and type(G.jokers.cards[i].ability.extra) == "table" and G.jokers.cards[i].ability.extra.insc_tentacle_trigger ~= nil and G.jokers.cards[i].ability.extra.insc_tentacle_trigger then
                    card.ability.sigil[index].tentacle = card.ability.sigil[index].tentacle + 1
                end
            end
        end
        if card.debuff then
            card.debuff = false
        end
    end
}

--Handy
BalatroInscrybed.Sigil { 
    name = "insc_Handy",
    key = "handy",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            local cards = {}
            local destroyed_cards = {}
            for i=1, #G.hand.cards do
                G.hand.cards[i]:calculate_seal({discard = true})
                local removed = false
                for j = 1, #G.jokers.cards do
                    local eval = nil
                    eval = G.jokers.cards[j]:calculate_joker({discard = true, other_card =  G.hand.cards[i], full_hand = G.hand.cards})
                    if eval then
                        if eval.remove then removed = true end
                        card_eval_status_text(G.jokers.cards[j], 'jokers', nil, 1, nil, eval)
                    end
                end
                table.insert(cards, G.hand.cards[i])
                if removed then
                    destroyed_cards[#destroyed_cards + 1] = G.hand.cards[i]
                    if G.hand.cards[i].ability.name == 'Glass Card' then 
                        G.hand.cards[i]:shatter()
                    else
                        G.hand.cards[i]:start_dissolve()
                    end
                else 
                    G.hand.cards[i].ability.discarded = true
                    draw_card(G.hand, G.discard, i*100/#G.hand.cards, 'down', false, G.hand.cards[i])
                end
            end
            local hand_space = math.min(#G.deck.cards, G.hand.config.card_limit - #G.hand.cards)
            delay(0.3)
            for i=1, hand_space do 
                if G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK then 
                    draw_card(G.deck,G.hand, i*100/hand_space,'up', true)
                else
                    draw_card(G.deck,G.hand, i*100/hand_space,'up', true)
                end
            end
        end
    end,
}

--Scavenger
BalatroInscrybed.Sigil { 
    name = "insc_Scavenger",
    key = "scavenger",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            if G.GAME.current_round.discards_used ~= 0 then
                return {
                    dollars = (G.GAME.current_round.discards_used*2),
                    colour = G.C.MONEY
                }
            end
        end
    end,
}

--Battery Bearer
BalatroInscrybed.Sigil { 
    name = "insc_Battery_Bearer",
    key = "battery_bearer",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=7},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            for i = 1,#context.hand_drawn do
                if context.hand_drawn[i] == card then
                    ease_hands_played(1)
                end
            end
        end
    end
}

--Mighty Leap
BalatroInscrybed.Sigil { 
    name = "insc_Mighty_Leap",
    key = "mighty_leap",
    badge_colour = HEX("9fff80"),
    config = { trigger = false },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.discard and context.other_card == card then
            if card.sigil[index] ~= nil then
                if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                    G.GAME.blind:disable()
                    card:start_dissolve()
                    card.ability.sigil[index].trigger = true
                end
            end 
        end
        if context.destroying_card and card.ability.sigil[index].trigger then 
            return { remove = true }
        end
    end
}

--Morsel
BalatroInscrybed.Sigil { 
    name = "insc_Morsel",
    key = "morsel",
    badge_colour = HEX("9fff80"),
    config = { trigger = false },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.discard and context.other_card == card then
            if card.sigil[index] ~= nil then
                if G.GAME.last_hand_played ~= nil then
                    local hand_type = G.GAME.last_hand_played
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(hand_type, 'poker_hands'),chips = G.GAME.hands[hand_type].chips, mult = G.GAME.hands[hand_type].mult, level=G.GAME.hands[hand_type].level})
                    level_up_hand(card, hand_type, nil, 1)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                    delay(0.4)
                    card:start_dissolve()
                    card.ability.sigil[index].trigger = true
                end
            end 
        end
    end
}

--Gift Bearerer
BalatroInscrybed.Sigil { 
    name = "insc_Gift_Bearer",
    key = "gifter",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=2},
    loc_vars = function(self, info_queue, card)
    return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            if #G.jokers.cards < G.jokers.config.card_limit then 
                local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gifter')
                card_:add_to_deck()
                G.jokers:emplace(card_)
                card_:start_materialize()
                G.GAME.joker_buffer = 0
                return{
                    message = {
                        "gift!"
                    }
                }
            end
        end
    end
}

--Brood Parasite
BalatroInscrybed.Sigil { 
    name = "insc_Brood_Parasite",
    key = "parasite",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            if #G.jokers.cards < G.jokers.config.card_limit then 
                local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_egg", 'parasite')
                card_:add_to_deck()
                G.jokers:emplace(card_)
                card_:start_materialize()
                G.GAME.joker_buffer = 0
                return{
                    message = {
                        "egg!"
                    }
                }
            end
        end
    end
}

--Touch of Death
BalatroInscrybed.Sigil { 
    name = "insc_Touch_of_Death",
    key = "touch_death", --Please dont
    badge_colour = HEX("9fff80"),
    config = {xmult = 0, x_mult_mod = 1.5},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=3},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].xmult, card.ability.sigil[index].x_mult_mod} }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.sigil[index].xmult ~= 0 then
                SMODS.calculate_effect({x_mult_mod = card.ability.sigil[index].xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil[index].xmult}}}, card)
            end
            if #G.jokers.cards ~= 0 then
                card.ability.sigil[index].xmult = card.ability.sigil[index].xmult + card.ability.sigil[index].x_mult_mod
                local jindex = math.random(1,#G.jokers.cards)
                G.jokers.cards[jindex]:start_dissolve()
            end
            
        end
    end,
}

--Double Strike
BalatroInscrybed.Sigil { 
    name = "insc_Double_Strike",
    key = "double",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}

--Corpse Eater
--BalatroInscrybed.Sigil { 
--    name = "insc_Corpse_Eater",
--    key = "corpse_eater",
--    badge_colour = HEX("9fff80"),
--    config = { insert_in_deck = {false, "length"}, context_discard = false, context_hand = false },
--    atlas = 'sigils',
--    atlas_extra = 'sigilsextra',
--    pos = {x=7, y=4},
--    loc_vars = function(self, info_queue, card)
--        return { vars = { } }
--    end,
--}

--Guardian
BalatroInscrybed.Sigil { 
    name = "insc_Guardian",
    key = "guardian",
    badge_colour = HEX("9fff80"),
    config = { insert_in_deck = {false, "length"} },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=10, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if G.deck ~= nil and G.GAME.blind and (G.GAME.blind:get_type() == 'Boss') then
            card.ability.sigil[index].insert_in_deck[1] = true
        elseif G.GAME.blind and (G.GAME.blind:get_type() ~= 'Boss') then
            card.ability.sigil[index].insert_in_deck[1] = false
        end
    end
}

--Armored
BalatroInscrybed.Sigil { 
    name = "insc_Armored",
    key = "armored",
    badge_colour = HEX("9fff80"),
    config = { no_discard_score = {false, "hand"} },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            card.ability.sigil[index].no_discard_score[1] = true
        end
        if context.before then
            local unscoring_cards = {}
            local scoring_lookup = {}
            for i = 1, #context.scoring_hand do
                scoring_lookup[context.scoring_hand[i]] = true
            end
            for i = 1, #context.full_hand do
                local _card = context.full_hand[i]
                if not scoring_lookup[_card] then
                    table.insert(unscoring_cards, _card)
                end
            end
            for i = 1, #unscoring_cards do
                if card == unscoring_cards[i] then
                    card.ability.sigil[index].no_discard_score[1] = false
                end
            end
        end
    end,
}

--Burrower
BalatroInscrybed.Sigil { 
    name = "insc_Burrower",
    key = "burrower",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local unscoring_cards = {}
            local scoring_lookup = {}
            for i = 1, #context.scoring_hand do
                scoring_lookup[context.scoring_hand[i]] = true
            end
            for i = 1, #context.full_hand do
                local _card = context.full_hand[i]
                if not scoring_lookup[_card] then
                    table.insert(unscoring_cards, _card)
                end
            end
            for i = 1, #unscoring_cards do
                if card == unscoring_cards[i] then
                    G.GAME.insc_extra_draw = G.GAME.insc_extra_draw + 1
                end
            end
        end
    end,
}

--Detonator
BalatroInscrybed.Sigil { 
    name = "insc_Detonator",
    key = "detonator",
    badge_colour = HEX("9fff80"),
    config = {trigger = false},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=11, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        local remove_table = {}
        if card.ability.sigil[index].trigger and not context.remove_playing_cards then
            if G.hand ~= nil then
                for i = 1, #G.hand.cards do
                    if G.hand.cards[i] == card then
                        if #G.hand.cards == 1 then
                            return
                        elseif i == 1 then
                            table.insert(remove_table, G.hand.cards[i+1])
                        elseif i == #G.hand.cards then
                            table.insert(remove_table, G.hand.cards[i-1])
                        else
                            local cards = {G.hand.cards[i-1], G.hand.cards[i+1]}
                            for j = 1, #cards do
                                table.insert(remove_table, cards[j])
                            end
                        end
                    end
                end
            end
            if G.play ~= nil then
                for i = 1, #G.play.cards do
                    if G.play.cards[i] == card then
                        if #G.play.cards == 1 then
                            return
                        elseif i == 1 then
                            table.insert(remove_table, G.play.cards[i+1])
                        elseif i == #G.play.cards then
                            table.insert(remove_table, G.play.cards[i-1])
                        else
                            local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                            for j = 1, #cards do
                                table.insert(remove_table, cards[j])
                            end
                        end
                    end
                end
            end
        end
        if context.remove_playing_cards and not context.blueprint then
            for l = 1, #context.removed do
                if context.removed[l] == card then
                    if G.hand ~= nil then
                        for i = 1, #G.hand.cards do
                            if G.hand.cards[i] == card then
                                if #G.hand.cards == 1 then
                                    return
                                elseif i == 1 then
                                    table.insert(remove_table, G.hand.cards[i+1])
                                elseif i == #G.hand.cards then
                                    table.insert(remove_table, G.hand.cards[i-1])
                                else
                                    local cards = {G.hand.cards[i-1], G.hand.cards[i+1]}
                                    for j = 1, #cards do
                                        table.insert(remove_table, cards[j])
                                    end
                                end
                            end
                        end
                    end
                    if G.play ~= nil then
                        for i = 1, #G.play.cards do
                            if G.play.cards[i] == card then
                                if #G.play.cards == 1 then
                                    return
                                elseif i == 1 then
                                    table.insert(remove_table, G.play.cards[i+1])
                                elseif i == #G.play.cards then
                                    table.insert(remove_table, G.play.cards[i-1])
                                else
                                    local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                                    for j = 1, #cards do
                                        table.insert(remove_table, cards[j])
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if #remove_table > 1 then
            for i = 1, #remove_table do
                local index2 = nil
                if remove_table[i].sigil ~= nil then
                    if remove_table[i].sigil[1] ~= nil and remove_table[i].sigil[1] == self.key then
                        index2 = 1
                    elseif remove_table[i].sigil[2] ~= nil and remove_table[i].sigil[2] == self.key then
                        index2 = 2
                    end
                end
                if remove_table[i].sigil ~= nil and index ~= nil then
                    remove_table[i].ability.sigil[index].trigger = true
                else
                    remove_table[i]:start_dissolve()
                end
            end
        end
        if card.ability.sigil[index].trigger and not context.remove_playing_cards then
            card:start_dissolve()
        end
    end
}

--Ant
BalatroInscrybed.Sigil { 
    name = "insc_Ant",
    key = "ant",
    badge_colour = HEX("9fff80"),
    config = {ants = 0, odds = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=3},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].ants, G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            local index = nil
            if card.sigil ~= nil then
                if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                    index = 1
                elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                    index = 2
                end
            end
            local retriggers = 0
            for i = 1, card.ability.sigil[index].ants do
                if pseudorandom('ant') < G.GAME.probabilities.normal / card.ability.sigil[index].odds then
                    retriggers = retriggers + 1
                end
            end
            if retriggers > 0 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = retriggers,
                    card = card
                }
            end
        end
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        card.ability.sigil[index].ants = 0
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.hand.cards[i].ability.sigil[1].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.hand.cards[i].ability.sigil[2].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                    end
                end
            end
        end
        if G.play ~= nil then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.play.cards[i].ability.sigil[1].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.play.cards[i].ability.sigil[2].ants then
                                card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                            end
                        end
                    end
                end
            end
        end
        if G.jokers ~= nil then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.insc_ant_trigger ~= nil and G.jokers.cards[i].ability.insc_ant_trigger then
                    card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                end
                if G.jokers.cards[i].ability.extra ~= nil and type(G.jokers.cards[i].ability.extra) == "table" and G.jokers.cards[i].ability.extra.insc_ant_trigger ~= nil and G.jokers.cards[i].ability.extra.insc_ant_trigger then
                    card.ability.sigil[index].ants = card.ability.sigil[index].ants + 1
                end
            end
        end
    end
}

--Clinger
BalatroInscrybed.Sigil { 
    name = "insc_Clinger",
    key = "clinger",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=1, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            if (card.area.config.type == 'hand') then
                local in_hand = false
                if card.highlighted and G.hand.highlighted[i] == card then
                    return
                else
                    card:highlight(true)
                    for i = 1, #G.hand.highlighted do
                        if G.hand.highlighted[i] == card then
                            in_hand = true
                            return
                        end
                    end
                    if not in_hand then
                        table.insert(G.hand.highlighted, card)
                    end
                end
            end
        end
    end,
}

--Ant Spawner
BalatroInscrybed.Sigil { 
    name = "insc_Ant_Spawner",
    key = "ant_spawner",
    badge_colour = HEX("9fff80"),
    config = {ants = 0, odds = 4},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=3},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {G.GAME.probabilities.normal or 1, card.ability.sigil[index].odds} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local index = nil
            if card.sigil ~= nil then
                if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                    index = 1
                elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                    index = 2
                end
            end
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then
                    if #G.play.cards == 1 then
                        return
                    elseif i == 1 then
                        if pseudorandom('ant_spawner') < G.GAME.probabilities.normal / card.ability.sigil[index].odds then
						    G.play.cards[i+1]:set_sigil("insc_ant", nil, false)
                        end
                    elseif i == #G.play.cards then
                        if pseudorandom('ant_spawner') < G.GAME.probabilities.normal / card.ability.sigil[index].odds then
						    G.play.cards[i-1]:set_sigil("insc_ant", nil, false)
                        end
                    else
                        local cards = {G.play.cards[i-1], G.play.cards[i+1]}
                        for j = 1, #cards do
                            if pseudorandom('ant_spawner') < G.GAME.probabilities.normal / card.ability.sigil[index].odds then
                                cards[j]:set_sigil("insc_ant", nil, false)
                            end
                        end
                    end
                end
            end
        end
    end,
}

--Many Lives
BalatroInscrybed.Sigil { 
    name = "insc_Many_Lives",
    key = "lives",
    badge_colour = HEX("9fff80"),
    config = {no_discard_score = {true, "deck"}, no_discard_hand = true, no_destroy = {true, false}},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}

--Shield Latch
BalatroInscrybed.Sigil { 
    name = "insc_Shield_Latch",
    key = "shield_latch",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_chariot", 'trinket')
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            card:juice_up(0.3, 0.5)
                        end
                        return true end }))
                    delay(0.6)
                end
            end
        end
    end
}

--Bomb Latch
BalatroInscrybed.Sigil { 
    name = "insc_Bomb_Latch",
    key = "bomb_latch",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_hanged_man", 'trinket')
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            card:juice_up(0.3, 0.5)
                        end
                        return true end }))
                    delay(0.6)
                end
            end
        end
    end
}

--Brittle Latch
BalatroInscrybed.Sigil { 
    name = "insc_Brittle_Latch",
    key = "brittle_latch",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_justice", 'trinket')
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            card:juice_up(0.3, 0.5)
                        end
                        return true end }))
                    delay(0.6)
                end
            end
        end
    end
}

--Unkillable
BalatroInscrybed.Sigil { 
    name = "insc_Unkillable",
    key = "unkillable",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    local index = nil
                    if card.sigil ~= nil then
                        if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                            index = 1
                        elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                            index = 2
                        end
                    end
                    for j = 1, 3 do
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(card, nil, nil, G.playing_card)
                        _card:set_sigil(nil, index)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        })) 
                    end
                end
            end
        end
    end
}

--Loose Tail
BalatroInscrybed.Sigil { 
    name = "insc_Loose_Tail",
    key = "tail",
    badge_colour = HEX("9fff80"),
    config = {no_destroy = {true, true, 1}},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=5},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    local index = nil
                    if card.sigil ~= nil then
                        if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                            index = 1
                        elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                            index = 2
                        end
                    end
                    if card.ability.sigil[index].no_destroy[3] ~= nil and card.ability.sigil[index].no_destroy[3] ~= 0 then
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(card, nil, nil, G.playing_card)
                        local _suit = string.sub(card.base.suit, 1, 1)..'_'
                        local rank_suffix = card.base.id == 14 and 2 or math.min(math.floor(card.base.id / 2), 14)
                        if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                        elseif rank_suffix == 10 then rank_suffix = 'T'
                        elseif rank_suffix == 11 then rank_suffix = 'J'
                        elseif rank_suffix == 12 then rank_suffix = 'Q'
                        elseif rank_suffix == 13 then rank_suffix = 'K'
                        elseif rank_suffix == 14 then rank_suffix = 'A'
                        end
                        _card:set_base(G.P_CARDS[_suit..rank_suffix])
                        _card:set_sigil(nil, index)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        })) 
                    end
                end
            end
        end
    end
}

--Frozen Away
BalatroInscrybed.Sigil { 
    name = "insc_Frozen_Away",
    key = "frozen",
    badge_colour = HEX("9fff80"),
    config = {chips = 30, mult = 15},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=6},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].chips, card.ability.sigil[index].mult} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    local index = nil
                    if card.sigil ~= nil then
                        if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                            index = 1
                        elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                            index = 2
                        end
                    end
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(card, nil, nil, G.playing_card)
                    _card:set_sigil(nil, index)
                    _card.ability.perma_bonus = _card.ability.perma_bonus + card.ability.sigil[index].chips
                    _card.ability.perma_mult = _card.ability.perma_mult + card.ability.sigil[index].mult
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                        end
                    })) 
                end
            end
        end
    end
}

--Swapper
BalatroInscrybed.Sigil { 
    name = "insc_Swapper",
    key = "swapper",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('insc_swap'), colour = G.C.PURPLE })
            local chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"nominal"}, false, true, "base")
            local mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "base")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            local chip_map = {
                chip_mod = "mult_mod",
                h_chips = "h_mult",
            }

            local chip_keys, mult_keys = {}, {}
            for chip, mult in pairs(chip_map) do
                table.insert(chip_keys, chip)
                table.insert(mult_keys, mult)
            end

            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, chip_keys, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, mult_keys, false, true, "ability.extra")

            for i, chip in ipairs(chip_keys) do
                local mult = chip_map[chip]

                if chips[i] and mult then
                    local m_val = m_value[i] ~= nil and m_value[i] or (m_value[#m_value] or 0)
                    local c_val = c_value[i] ~= nil and c_value[i] or (c_value[#c_value] or 0)

                    if chips[i] then
                        insc_ability_calculate(card, "=", m_val, nil, {chips[i]}, false, true, "ability.extra")
                    end
                    if mult then
                        insc_ability_calculate(card, "=", c_val, nil, {mult}, false, true, "ability.extra")
                    end
                end
            end
            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_bonus"}, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "/", 2, nil, {mult[1]}, false, true, "ability.extra")
        end
        if context.final_scoring_step then
            local chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"nominal"}, false, true, "base")
            local mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "base")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            local chip_map = {
                chip_mod = "mult_mod",
                h_chips = "h_mult",
            }

            local chip_keys, mult_keys = {}, {}
            for chip, mult in pairs(chip_map) do
                table.insert(chip_keys, chip)
                table.insert(mult_keys, mult)
            end

            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, chip_keys, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, mult_keys, false, true, "ability.extra")

            for i, chip in ipairs(chip_keys) do
                local mult = chip_map[chip]

                if chips[i] and mult then
                    local m_val = m_value[i] ~= nil and m_value[i] or (m_value[#m_value] or 0)
                    local c_val = c_value[i] ~= nil and c_value[i] or (c_value[#c_value] or 0)

                    if chips[i] then
                        insc_ability_calculate(card, "=", m_val, nil, {chips[i]}, false, true, "ability.extra")
                    end
                    if mult then
                        insc_ability_calculate(card, "=", c_val, nil, {mult}, false, true, "ability.extra")
                    end
                end
            end
            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_bonus"}, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "*", 2, nil, {chips[1]}, false, true, "ability.extra")
        end
    end
}

--Amorphous
BalatroInscrybed.Sigil { 
    name = "insc_Amorphous",
    key = "amorphous",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' then 
                    cen_pool[#cen_pool+1] = v
                end
            end
            local ed = pseudorandom_element(cen_pool, pseudoseed('amorphous_card'))
            card:set_ability(ed)
        end
    end
}

--Tidal Lock
BalatroInscrybed.Sigil { 
    name = "insc_Tidal_Lock",
    key = "tidal",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            G.E_MANAGER:add_event(Event({
				func = (function()
					add_tag(Tag('tag_meteor'))
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
        end
    end
}

--Attack Conduit
BalatroInscrybed.Sigil { 
    name = "insc_Attack_Conduit",
    key = "atkconduit",
    badge_colour = HEX("9fff80"),
    config = {mult = 7, circuit_active = false},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=4},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].mult} }
    end,
    circuit = true,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].ability.in_between_circuit then
                    SMODS.calculate_effect({mult_mod = card.ability.sigil[index].mult, message = localize{type='variable',key='a_mult',vars={card.ability.sigil[index].mult}}}, G.play.cards[i])
                end
            end
        end
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if G.hand ~= nil then
            local conduits = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.hand.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.hand.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
        if G.play ~= nil then
            local conduits = {}
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.play.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.play.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
    end,
}

--Energy Conduit
BalatroInscrybed.Sigil { 
    name = "insc_Energy_Conduit",
    key = "energy_conduit",
    badge_colour = HEX("9fff80"),
    config = { circuit_active = false, no_hand_remove = true, hands_left = nil, r_hands_left = nil, way_to_much_configs = 0},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    circuit = true,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.hand_drawn or context.first_hand_drawn then
            card.ability.sigil[index].hands_left = G.GAME.current_round.hands_left
            self.config.way_to_much_configs = 0
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil and ((G.play.cards[i].sigil[1] ~= nil and G.play.cards[i].ability.sigil[1].no_hand_remove) or (G.play.cards[i].sigil[2] ~= nil and G.play.cards[i].ability.sigil[2].no_hand_remove)) then 
                    if G.play.cards[i].ability.sigil[index].circuit_active and G.play.cards[i].ability.sigil[index].hands_left ~= nil then
                        if (G.play.cards[i].ability.sigil[index].hands_left) > (self.config.r_hands_left) then
                            ease_hands_played(1)
                            self.config.way_to_much_configs = self.config.way_to_much_configs + 1
                            self.config.r_hands_left = self.config.r_hands_left + 1
                            break
                        end
                    end
                end
            end
        end
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        self.config.r_hands_left = G.GAME.current_round.hands_left + self.config.way_to_much_configs
        if G.hand ~= nil then
            local conduits = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.hand.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.hand.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
        if G.play ~= nil then
            local conduits = {}
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.play.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.play.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
    end,
}

--Gem Spawn Conduit
BalatroInscrybed.Sigil { 
    name = "insc_Gem_Spawn_Conduit",
    key = "gemconduit",
    badge_colour = HEX("9fff80"),
    config = {x_mult = 1.5, circuit_active = false},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=4, y=4},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].x_mult} }
    end,
    circuit = true,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].ability.in_between_circuit and SMODS.has_enhancement(G.play.cards[i],'m_stone') then
                    SMODS.calculate_effect({Xmult_mod = card.ability.sigil[index].x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil[index].x_mult}}}, G.play.cards[i])
                end
            end
        end
    end,
    update = function(self, card, dt)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if G.hand ~= nil then
            local conduits = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.hand.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.hand.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
        if G.play ~= nil then
            local conduits = {}
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[1]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[2]].circuit then
                                table.insert(conduits, i)
                            end
                        end
                    end
                end
                G.play.cards[i].ability.in_between_circuit = false
                card.ability.sigil[index].circuit_active = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.play.cards[i].ability.in_between_circuit = true 
                        card.ability.sigil[index].circuit_active = true
                    end
                end
            end
        end
    end,
}

--Buff When Powered
BalatroInscrybed.Sigil { 
    name = "insc_Buff_When_Powered",
    key = "buff_powered",
    badge_colour = HEX("9fff80"),
    config = {x_mult = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=9, y=4},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].x_mult} }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.in_between_circuit then
                SMODS.calculate_effect({Xmult_mod = card.ability.sigil[index].x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil[index].x_mult}}}, card)
            end
        end
    end,
}

--Gift When Powered
BalatroInscrybed.Sigil { 
    name = "insc_Gift_When_Powered",
    key = "gift_powered",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before then
            if card.ability.in_between_circuit then
                local unscoring_cards = {}
                local scoring_lookup = {}
                for i = 1, #context.scoring_hand do
                    scoring_lookup[context.scoring_hand[i]] = true
                end
                for i = 1, #context.full_hand do
                    local _card = context.full_hand[i]
                    if not scoring_lookup[_card] then
                        table.insert(unscoring_cards, _card)
                    end
                end
                for i = 1, #unscoring_cards do
                    if card == unscoring_cards[i] then
                         if #G.jokers.cards < G.jokers.config.card_limit then 
                            local card_ = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gift_powered')
                            card_:add_to_deck()
                            G.jokers:emplace(card_)
                            card_:start_materialize()
                            G.GAME.joker_buffer = 0
                            return
                        end
                    end
                end
            end
        end
    end,
}

--Trifurcated When Powered
BalatroInscrybed.Sigil { 
    name = "insc_Trifurcated_When_Powered",
    key = "trifurcated_powered",
    badge_colour = HEX("9fff80"),
    config = {furcated = 1},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=7, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.hand.cards[i].sigil ~= nil then
                        if G.hand.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[1]].furcated then
                                if G.hand.cards[i].ability.in_between_circuit then
                                    G.hand.cards[i].ability.sigil[1].furcated = 3
                                else
                                    G.hand.cards[i].ability.sigil[1].furcated = 1
                                end
                            end
                        end
                        if G.hand.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.hand.cards[i].sigil[2]].furcated then
                                if G.hand.cards[i].ability.in_between_circuit then
                                    G.hand.cards[i].ability.sigil[2].furcated = 3
                                else
                                    G.hand.cards[i].ability.sigil[2].furcated = 1
                                end
                            end
                        end
                    end
                end
            end
        end
        if G.play ~= nil then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.play.cards[i].sigil ~= nil then
                        if G.play.cards[i].sigil[1] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[1]].furcated then
                                if G.play.cards[i].ability.in_between_circuit then
                                    G.play.cards[i].ability.sigil[1].furcated = 3
                                else
                                    G.play.cards[i].ability.sigil[1].furcated = 1
                                end
                            end
                        end
                        if G.play.cards[i].sigil[2] ~= nil then
                            if G.P_SIGILS[G.play.cards[i].sigil[2]].furcated then
                                if G.play.cards[i].ability.in_between_circuit then
                                    G.play.cards[i].ability.sigil[2].furcated = 3
                                else
                                    G.play.cards[i].ability.sigil[2].furcated = 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end,
}

--Fledgling
BalatroInscrybed.Sigil { 
    name = "insc_Fledgling",
    key = "fledgling",
    badge_colour = HEX("9fff80"),
    config = {mult = 0, mult_mod = 5},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=11, y=5},
    loc_vars = function(self, info_queue, card)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        return { vars = {card.ability.sigil[index].mult, card.ability.sigil[index].mult_mod} }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.sigil[index].mult ~= 0 then
                SMODS.calculate_effect({mult_mod = card.ability.sigil[index].mult, message = localize{type='variable',key='a_mult',vars={card.ability.sigil[index].mult}}}, card)
            end
        end
        if context.before then
            local unscoring_cards = {}
            local scoring_lookup = {}
            for i = 1, #context.scoring_hand do
                scoring_lookup[context.scoring_hand[i]] = true
            end
            for i = 1, #context.full_hand do
                local _card = context.full_hand[i]
                if not scoring_lookup[_card] then
                    table.insert(unscoring_cards, _card)
                end
            end
            for i = 1, #unscoring_cards do
                if card == unscoring_cards[i] then
                    card.ability.sigil[index].mult = card.ability.sigil[index].mult + card.ability.sigil[index].mult_mod
                end
            end
        end
    end,
}

--Worthy Sacrifice
BalatroInscrybed.Sigil { 
    name = "insc_Worthy_Sacrifice",
    key = "sacrifice",
    badge_colour = HEX("9fff80"),
    config = {extra = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=3},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.extra+1}
        }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            G.GAME.insc_extra_draw = G.GAME.insc_extra_draw + self.config.extra
        end
    end
}

--Bellist
BalatroInscrybed.Sigil { 
    name = "insc_Bellist",
    key = "bellist",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=2, y=4},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand and not context.end_of_round then
            local valid_cards = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i] == card then
                    if #G.hand.cards == 1 then
                        table.insert(valid_cards, G.hand.cards[i])
                    elseif i == 1 then
                        table.insert(valid_cards, G.hand.cards[i+1])
                        table.insert(valid_cards, G.hand.cards[i])
                    elseif i == #G.hand.cards then
                        table.insert(valid_cards, G.hand.cards[i-1])
                        table.insert(valid_cards, G.hand.cards[i])
                    else
                        table.insert(valid_cards, G.hand.cards[i+1])
                        table.insert(valid_cards, G.hand.cards[i])
                        table.insert(valid_cards, G.hand.cards[i-1])
                    end
                end
            end
            for i = 1, #valid_cards do
                if valid_cards[i].config.center.key ~= "c_base" then
                    local effect = G.P_CENTERS[valid_cards[i].config.center.key].config
                    local scored_card = valid_cards[i]
                    for _, key in ipairs(SMODS.calculation_keys) do
                        if effect["bonus"] ~= nil then
                            effect = {chips = effect["bonus"]}
                        end
                        if effect[key] and key ~= "extra" then
                            if effect.juice_card then G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function () effect.juice_card:juice_up(0.1); scored_card:juice_up(0.1); return true end})) end
                            SMODS.calculate_individual_effect(effect, scored_card, key, effect[key])
                        end
                    end
                end
            end
        end
    end
}

--Bone Digger
BalatroInscrybed.Sigil { 
    name = "insc_Bone_Digger",
    key = "digger",
    badge_colour = HEX("9fff80"),
    config = {active = false, trigger = 0},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=5, y=5},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        local index = nil
        if card.sigil ~= nil then
            if card.sigil[1] ~= nil and card.sigil[1] == self.key then
                index = 1
            elseif card.sigil[2] ~= nil and card.sigil[2] == self.key then
                index = 2
            end
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil and card == G.play.cards[i] then
                    G.GAME.insc_extra_draw = G.GAME.insc_extra_draw - 1
                    break
                end
            end
        end
        if G.hand ~= nil then
            local _card = nil
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil and card == G.hand.cards[i] then
                    card.ability.sigil[index].trigger = 1
                    _card = G.hand.cards[i]
                    break
                end
            end
            if _card ~= nil then
                if _card.sigil ~= nil then
                    if _card.sigil[index] ~= nil then
                        if card.ability.sigil[index].trigger == 1 then
                            if not card.ability.sigil[index].active then
                                G.GAME.insc_extra_draw = G.GAME.insc_extra_draw + 1
                                card.ability.sigil[index].active = true
                                card.ability.sigil[index].trigger = -1
                            end
                        else
                            if card.ability.sigil[index].active then
                                G.GAME.insc_extra_draw = G.GAME.insc_extra_draw - 1
                                card.ability.sigil[index].active = false
                            end
                        end
                        if context.hand_drawn then
                            card.ability.sigil[index].trigger = 1
                            card.ability.sigil[index].active = false
                        end
                    end
                end 
            end
        end
    end
}

--Waterborne
BalatroInscrybed.Sigil { 
    name = "insc_Waterborne",
    key = "waterborne",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=11, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    update = function(self, card, dt)
        if card.debuff then
            card.debuff = false
        end
    end,
}

--Airborne
BalatroInscrybed.Sigil { 
    name = "insc_Airborne",
    key = "airborne",
    badge_colour = HEX("9fff80"),
    config = {always_scores = true,},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=7},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}

--Made of Stone
BalatroInscrybed.Sigil { 
    name = "insc_Made_of_Stone",
    key = "stone",
    badge_colour = HEX("9fff80"),
    config = {counts_as_enhance = "m_stone"},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=3, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}

--Bifurcated Strike
BalatroInscrybed.Sigil { 
    name = "insc_Bifurcated_Strike",
    key = "bifurcated",
    badge_colour = HEX("9fff80"),
    config = {furcated = 2},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=8, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}

--Trifurcated Strike
BalatroInscrybed.Sigil { 
    name = "insc_Trifurcated_Strike",
    key = "trifurcated",
    badge_colour = HEX("9fff80"),
    config = {furcated = 3},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}

--Overclocked
BalatroInscrybed.Sigil { 
    name = "insc_Overclocked",
    key = "overclocked",
    badge_colour = HEX("9fff80"),
    config = { x_mult = 2, odds = 2 },
    loc_vars = function(self, info_queue)
        return { vars = { self.config.x_mult, G.GAME.probabilities.normal or 1, self.config.odds} }
    end,
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=1, y=2},
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = self.config.x_mult,
            }
        end
        if context.destroying_card and (hand_chips * mult) + G.GAME.chips < G.GAME.blind.chips then 
            if pseudorandom('overclocked') < G.GAME.probabilities.normal / self.config.odds then
                return { remove = true }
            end
        end
    end,
}

