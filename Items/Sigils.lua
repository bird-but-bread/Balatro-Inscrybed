BalatroInscrybed.Sigil = SMODS.GameObject:extend {
    obj_table = BalatroInscrybed.Sigils,
    obj_buffer = {},
    rng_buffer = {},
    badge_to_key = {},
    set = 'Sigil',
    atlas = 'centers',
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

-- Sigils

--fecundity 
BalatroInscrybed.Sigil { 
    name = "insc_fecundity",
    key = "fecundity",
    badge_colour = HEX("9fff80"),
    config = { odds = 4 },
    atlas = 'sigils',
    pos = {x=8, y=3},
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

--Gift Bearererere
BalatroInscrybed.Sigil { 
    name = "insc_Gift_Bearer",
    key = "gifter",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=4, y=3},
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
    pos = {x=4, y=4},
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

--Double Strike
BalatroInscrybed.Sigil { 
    name = "insc_Double_Strike",
    key = "double",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=10, y=3},
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

--Many Lives
BalatroInscrybed.Sigil { 
    name = "insc_Many_Lives",
    key = "lives",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=1, y=2},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    no_discard = true,
}

--Unkillable
BalatroInscrybed.Sigil { 
    name = "insc_Unkillable",
    key = "unkillable",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=7, y=3},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                if context.removed[i] == card then
                    for j = 1, 3 do
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(card, nil, nil, G.playing_card)
                        _card:set_sigil(nil)
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

--Amorphous
BalatroInscrybed.Sigil { 
    name = "insc_Amorphous",
    key = "amorphous",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=4, y=2},
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
    pos = {x=4, y=1},
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
    config = {mult = 7},
    atlas = 'sigils',
    pos = {x=10, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.sigil.mult} }
    end,
    circuit = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].ability.in_between_circuit then
                    SMODS.calculate_effect({mult_mod = card.ability.sigil.mult, message = localize{type='variable',key='a_mult',vars={card.ability.sigil.mult}}}, G.play.cards[i])
                end
            end
        end
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            local conduits = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.P_SIGILS[G.hand.cards[i].sigil].circuit then
                        table.insert(conduits, i)
                    end
                end
                G.hand.cards[i].ability.in_between_circuit = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.hand.cards[i].ability.in_between_circuit = true 
                    end
                end
            end
        end
        if G.play ~= nil then
            local conduits = {}
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.P_SIGILS[G.play.cards[i].sigil].circuit then
                        table.insert(conduits, i)
                    end
                end
                G.play.cards[i].ability.in_between_circuit = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.play.cards[i].ability.in_between_circuit = true 
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
    config = {x_mult = 1.5},
    atlas = 'sigils',
    pos = {x=8, y=4},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.sigil.x_mult} }
    end,
    circuit = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if G.play.cards[i].ability.in_between_circuit and SMODS.has_enhancement(G.play.cards[i],'m_stone') then
                    SMODS.calculate_effect({Xmult_mod = card.ability.sigil.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil.x_mult}}}, G.play.cards[i])
                end
            end
        end
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            local conduits = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.P_SIGILS[G.hand.cards[i].sigil].circuit then
                        table.insert(conduits, i)
                    end
                end
                G.hand.cards[i].ability.in_between_circuit = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.hand.cards[i].ability.in_between_circuit = true 
                    end
                end
            end
        end
        if G.play ~= nil then
            local conduits = {}
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.P_SIGILS[G.play.cards[i].sigil].circuit then
                        table.insert(conduits, i)
                    end
                end
                G.play.cards[i].ability.in_between_circuit = false
            end
            if #conduits >= 2 then
                index1 = conduits[1]
                for i = index1, conduits[#conduits] do
                    if i ~= index1 and i ~= conduits[#conduits] then
                        G.play.cards[i].ability.in_between_circuit = true 
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
    pos = {x=2, y=5},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.sigil.x_mult} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.in_between_circuit then
                SMODS.calculate_effect({Xmult_mod = card.ability.sigil.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.sigil.x_mult}}}, card)
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
    pos = {x=1, y=5},
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
    config = {},
    atlas = 'sigils',
    pos = {x=0, y=5},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.sigil.mult} }
    end,
    furcated = 1,
    update = function(self, card, dt)
        if G.hand ~= nil then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].sigil ~= nil then
                    if G.P_SIGILS[G.hand.cards[i].sigil].furcated then
                        if G.hand.cards[i].ability.in_between_circuit then
                            G.P_SIGILS[G.hand.cards[i].sigil].furcated = 3
                        else
                            G.P_SIGILS[G.hand.cards[i].sigil].furcated = 1
                        end
                    end
                end
            end
        end
        if G.play ~= nil then
            for i = 1, #G.play.cards do
                if G.play.cards[i].sigil ~= nil then
                    if G.P_SIGILS[G.play.cards[i].sigil].furcated then
                        if G.play.cards[i].ability.in_between_circuit then
                            G.P_SIGILS[G.play.cards[i].sigil].furcated = 3
                        else
                            G.P_SIGILS[G.play.cards[i].sigil].furcated = 1
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
    pos = {x=5, y=8},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.sigil.mult, card.ability.sigil.mult_mod} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.sigil.mult ~= 0 then
                SMODS.calculate_effect({mult_mod = card.ability.sigil.mult, message = localize{type='variable',key='a_mult',vars={card.ability.sigil.mult}}}, card)
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
                    card.ability.sigil.mult = card.ability.sigil.mult + card.ability.sigil.mult_mod
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
    pos = {x=3, y=0},
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

--Waterborne
BalatroInscrybed.Sigil { 
    name = "insc_Waterborne",
    key = "waterborne",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=8, y=0},
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
    config = {},
    atlas = 'sigils',
    pos = {x=9, y=7},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    always_scores = true,
}

--Made of Stone
BalatroInscrybed.Sigil { 
    name = "insc_Made_of_Stone",
    key = "stone",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=5, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    counts_as_enhance = "m_stone"
}

--Bifurcated Strike
BalatroInscrybed.Sigil { 
    name = "insc_Bifurcated_Strike",
    key = "bifurcated",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=5, y=1},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    furcated = 2
}

--Trifurcated Strike
BalatroInscrybed.Sigil { 
    name = "insc_Trifurcated_Strike",
    key = "trifurcated",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    pos = {x=2, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    furcated = 3
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
    pos = {x=7, y=2},
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

