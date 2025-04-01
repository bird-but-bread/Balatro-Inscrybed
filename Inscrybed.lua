----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "sigils",
    path = "SigilAtlas.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "sigilsextra",
    path = "SigilAtlasExtra.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "spectrals",
    path = "Spectrals.png",
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
assert(SMODS.load_file("Items/spectral.lua"))()

SMODS.DrawStep {
    key = 'sigil',
    order = 34,
    func = function(self, layer)
        if self.sigil ~= nil and self.sigil[1] ~= nil and G.shared_sigils[self.sigil[1]] then
            G.shared_sigils[self.sigil[1]].role.draw_major = self
            G.shared_sigils[self.sigil[1]]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep {
    key = 'sigilextra',
    order = 36,
    func = function(self, layer)
        if self.sigil ~= nil and self.sigil[2] ~= nil and G.shared_sigils2[self.sigil[2]] then
            G.shared_sigils2[self.sigil[2]].role.draw_major = self
            G.shared_sigils2[self.sigil[2]]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep {
    key = 'cicuit_shader',
    order = 15,
    func = function(self, layer)
        if self.ability.in_between_circuit ~= nil and self.ability.in_between_circuit then
            self.children.front:draw_shader('foil', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}


function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
		G.GAME.insc_extra_draw = 0
	end
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















     

----------------------------------------------
------------MOD CODE END----------------------
