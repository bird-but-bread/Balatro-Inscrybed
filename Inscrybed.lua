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
BalatroInscrybed.Sigils = {}



assert(SMODS.load_file("items/utility.lua"))()
assert(SMODS.load_file("Items/Sigils.lua"))()
assert(SMODS.load_file("Items/Jokers.lua"))()
assert(SMODS.load_file("Items/Decks.lua"))()

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
