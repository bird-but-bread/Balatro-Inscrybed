----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "sigils",
    path = "SigilAtlas.png",
    px = 73,
    py = 97
}
SMODS.Atlas {
    key = "sigilsextra",
    path = "SigilAtlasExtra.png",
    px = 73,
    py = 97
}
SMODS.Atlas {
    key = "insc_sacrifice_sign",
    path = "ShopSignAnimationTemp.png",
    px = 113,
    py = 57, 
    frames = 4,
    atlas_table = 'ANIMATION_ATLAS'
}
SMODS.Atlas { 
    key = "spectrals",
    path = "Spectrals.png",
    px = 71,
    py = 95
}
SMODS.Atlas { 
    key = "insc_events",
    path = "Events.png",
    px = 34,
    py = 34
}
SMODS.Atlas {
    key = "po3_cards",
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
BalatroInscrybed.insc_Events = {}

assert(SMODS.load_file("items/utility.lua"))()
assert(SMODS.load_file("Items/Sigils.lua"))()
assert(SMODS.load_file("Items/Jokers.lua"))()
assert(SMODS.load_file("Items/Decks.lua"))()
assert(SMODS.load_file("Items/spectral.lua"))()
assert(SMODS.load_file("Items/Events.lua"))()
assert(SMODS.load_file("Items/BaseEdits.lua"))()
assert(SMODS.load_file("Items/Utils/EventUI.lua"))()

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

SMODS.DrawStep {
    key = 'floating_sprite',
    order = 60,
    func = function(self)
        if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            if type(self.config.center.soul_pos.draw) == 'function' then
                self.config.center.soul_pos.draw(self, scale_mod, rotate_mod)
            elseif self.ability.name == 'Hologram' then
            elseif self.config.center.soul_pos.holo then
                self.hover_tilt = self.hover_tilt*1.3
                self.children.floating_sprite:draw_shader('hologram', nil, self.ARGS.send_to_shader, nil, self.children.center, 1.3*scale_mod, 0*rotate_mod)
                self.hover_tilt = self.hover_tilt/1.3
	            self.children.floating_sprite:draw_shader('hologram', nil, self.ARGS.send_to_shader, nil, self.children.center, 1.3*scale_mod, 0*rotate_mod)
            else
                self.children.floating_sprite:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end
            if self.edition then 
                for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                    if v.apply_to_float then
                        if self.edition[v.key:sub(3)] then
                            self.children.floating_sprite:draw_shader(v.shader, nil, nil, nil, self.children.center, scale_mod, rotate_mod)
                        end
                    end
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep {
    key = 'insc_num_layer',
    order = 61,
    func = function(self)
        if self.config.center.insc_num_layer and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            if type(self.config.center.insc_num_layer.draw) == 'function' then
                self.config.center.insc_num_layer.draw(self, scale_mod, rotate_mod)
            elseif self.config.center.insc_num_layer.holo then
                self.hover_tilt = self.hover_tilt
	            self.children.insc_floating_sprite_num:draw_shader('dissolve', nil, nil, nil, self.children.center, 0.25*scale_mod, 0*rotate_mod) 
	            self.children.insc_floating_sprite_num:draw_shader('hologram', nil, self.ARGS.send_to_shader, nil, self.children.center, 0.25*scale_mod, 0*rotate_mod)
            else
                self.children.insc_floating_sprite_num:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                self.children.insc_floating_sprite_num:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end
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
