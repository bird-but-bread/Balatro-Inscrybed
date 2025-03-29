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
            if context.cardarea == G.play and context.main_scoring then
                
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

