--- STEAMODDED HEADER
--- MOD_NAME: Sigils mod
--- MOD_ID: Sigils
--- MOD_AUTHOR: [bird but bread]
--- MOD_DESCRIPTION: adds some sigils from inscryption

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "sigils",
    path = "SigilAtlas.png",
    px = 71,
    py = 95
}

SMODS.Sigils = {}
    SMODS.Sigil = SMODS.GameObject:extend {
               obj_table = SMODS.Sigils,
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
        process_loc_text = function(self)
            SMODS.process_loc_text(G.localization.descriptions.Other, self.key:lower() .. '_sigil', self.loc_txt)
            SMODS.process_loc_text(G.localization.misc.labels, self.key:lower() .. '_sigil', self.loc_txt, 'label')
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


--this is the template for all the other sigils, this was made BEFORE it was changed into it's own object, and is still a seal

--SMODS.Sigil { 
--    --creates the visuals and sets the local vars
--    name = "replaece me ",
--    key = "replace me",
--    badge_colour = HEX("9fff80"),
--    config = { },
--    loc_txt = {
--        label = "Sigil",
--        name = "NAME",
--        text = {
--            "text"
--        },
--    },
--    atlas = 'sigils',
--}

function Card:calculate_sigil(context, key)
    local sigil = SMODS.Sigils[key]
    if self.ability[key] and type(sigil.calculate) == 'function' then
        local o = sigil:calculate(self, context)
        if o then
            if not o.card then o.card = self end
            return o
        end
    end
end

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
      definition = create_UIBox_your_collection_sigils(),
    }
end

create_UIBox_your_collection_sigil = function()
    return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Sigil, {5,5}, {
        snap_back = true,
        infotip = localize('ml_edition_seal_enhancement_explanation'),
        hide_single_page = true,
        collapse_single_page = true,
        center = 'c_base',
        h_mod = 1.03,
        modify_card = function(card, center)
            card:set_sigil(center.key, true)
        end,
    })
end

--fecundity 
SMODS.Sigil { 
    name = "fecundity",
    key = "test",
    badge_colour = HEX("9fff80"),
    config = { odds = 4 },
    loc_txt = {
        label = "Sigil",
        name = "fecundity",
        text = {
            "when a card bearing this Sigil is {C:attention}scored{}",
            "{C:green}#1# in #2#{} chance",
            "to create a {C:attention}copy{}",
        },
    },
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
SMODS.Sigil { 
    name = "Gift Bearer",
    key = "gifter",
    badge_colour = HEX("9fff80"),
    config = {},
    loc_txt = {
        label = "Sigil",
        name = "Gift Bearer",
        text = {
            "when a card", 
            "bearing this Sigil is {C:attention}Discarded{}",
            "Create a random joker",
        },
    },
    atlas = 'sigils',
    pos = {x=4, y=3},
    loc_vars = function(self, info_queue, card)
    return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.discard then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    if #G.jokers.cards < G.jokers.config.card_limit then 
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gifter')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0

                        return{
                            message = {
                                "gift!"
                            }
                        }
                    end
             
            return true
            end
            }))
        end
    end
}

--Overclocked
SMODS.Sigil { 
    name = "Overclocked",
    key = "overc",
    badge_colour = HEX("9fff80"),
    config = { x_mult = 2, odds = 2 },
    loc_txt = {
        label = "Sigil",
        name = "Overclocked",
        text = {
            "{X:mult,C:white} X#1# {} Mult.", 
            "If a card bearing this sigil is played and",
            "doesn't win, {C:green}#2# in #3#{} chance it breaks.",
        },
    },
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

----------------------------------------------
------------MOD CODE END----------------------
