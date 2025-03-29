--- STEAMODDED HEADER
--- MOD_NAME: Balatro Inscrybed
--- MOD_ID: Balatro_Inscrybed
--- PREFIX: insc
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
SMODS.Atlas {
    key = "po3",
    path = "po3_template.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "beast",
    path = "beast_sprites.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "dcc",
    path = "Death_card_Mockup.png",
    px = 640,
    py = 720
}
BalatroInscrybed = SMODS.current_mod

Deathcard = {}



            


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
    
    for i = #G.jokers.cards, 1, -1 do
        local card_ = G.jokers.cards[i]
        G.jokers:remove_card(card_)
        BalatroInscrybed.chose_card_one:emplace(card_)
    end
    SMODS.add_card{
        key = "j_insc_deathcard",
        BalatroInscrybed.chose_card_one
    } 
end

--if G and G.GAME and G.GAME.modifiers and G.GAME.modifiers.beast
    
--end


SMODS.Joker {
    name = "insc-deathcard",
    key = "deathcard",
    pos = { x = 0, y = 0 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    rarity = 1,
    cost = 20,
    blueprint_compat = true,
    atlas = "po3",
}


SMODS.Back {
    name = "insc-beast",
    key = "beast_deck",
    pos = { x = 0, y = 0 },
    config = { extra = {check = true, chips = 10 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,
    calculate = function(self, back, context)
        if context.main_scoring and context.cardarea == G.play and back.ability.extra.check == true then
            for i = 1, #context.scoring_hand do
                card_ = context.scoring_hand[i]
                if SMODS.has_enhancement(card_, "m_wild") then
                    back.ability.extra.check = false
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(card_, nil, nil, G.playing_card)
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
                    _card.ability.perma_bonus = _card.ability.perma_bonus or 0
                    _card.ability.perma_bonus = _card.ability.perma_bonus + back.ability.extra.chips
                end
            end
        end
        if context.end_of_round then
            back.ability.extra.check = true
        end
    end,
    atlas = "beast",
}



BalatroInscrybed.Sigils = {}
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
            card:set_sigil(center.key, true)
        end,
    })
end

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
SMODS.Consumable {
	set = "Spectral",
	name = "Sigilapply",
	key = "sigilapply",
	order = 8,
	config = {
		-- This will add a tooltip.
		mod_conv = "insc_overclocked_sigil",
		-- Tooltip args
		seal = { planets_amount = 3 },
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		-- Handle creating a tooltip with set args.
		info_queue[#info_queue + 1] =
			{ set = "Other", key = "insc_fecundity_sigil", specific_vars = { self.config.seal.planets_amount } }
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 4,
	atlas = "sigils",
	pos = { x = 0, y = 4 },
	use = function(self, card, area, copier) --Good enough
		local used_consumable = copier or card
		for i = 1, #G.hand.highlighted do
			local highlighted = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					highlighted:juice_up(0.3, 0.5)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if highlighted then
						highlighted:set_sigil("insc_fecundity")
					end
					return true
				end,
			}))
			delay(0.5)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
}

     

----------------------------------------------
------------MOD CODE END----------------------
