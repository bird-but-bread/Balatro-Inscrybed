----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "sigils",
    path = "SigilAtlas.png",
    px = 73,
    py = 97
}
SMODS.Atlas {
    key = "scribe_backs",
    path = "ChosenScribe.png",
    px = 73,
    py = 98
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
    key = "scribe_statues",
    path = "Statues.png",
    px = 142,
    py = 190
}
SMODS.Atlas {
    key = "leshy_cards",
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
local mod_path = ''..BalatroInscrybed.path

Deathcard = {}
BalatroInscrybed.Sigils = {}
BalatroInscrybed.insc_Events = {}
G.shared_insc_scribes = {}

assert(SMODS.load_file("Utils/Utility.lua"))()
assert(SMODS.load_file("Utils/EventUI.lua"))() 
assert(SMODS.load_file("Utils/BaseEdits.lua"))()
assert(SMODS.load_file("Utils/Gameobjects.lua"))()
assert(SMODS.load_file("Utils/Contexts.lua"))()

local folders = NFS.getDirectoryItems(mod_path.."Items")
local objects = {}

local function collect_item_files(base_fs, rel, out)
    for _, name in ipairs(NFS.getDirectoryItems(base_fs)) do
        local abs = base_fs.."/"..name
        local info = NFS.getInfo(abs)
        if info and info.type == "directory" then
            collect_item_files(abs, rel.."/"..name, out)
        elseif info and info.type == "file" and name:match("%.lua$") then
            table.insert(out, rel.."/"..name)
        end
    end
end

local files = {}
collect_item_files(mod_path.."Items", "Items", files)

local function load_items(curr_obj)
    if curr_obj.init then curr_obj:init() end
    if not curr_obj.items then
        print("Warning: curr_obj has no items")
        return
    end
    for _, item in ipairs(curr_obj.items) do
        item.ignore = item.ignore or false
        if SMODS[item.object_type] and not item.ignore then
            SMODS[item.object_type](item)
        elseif BalatroInscrybed[item.object_type] and not item.ignore then
            BalatroInscrybed[item.object_type](item)
        elseif CardSleeves and CardSleeves[item.object_type] and not item.ignore then
            CardSleeves[item.object_type](item)
        elseif not item.ignore then
            print("Error loading item "..item.key.." of unknown type "..item.object_type)
        end
        ::continue::
    end
end

for _, rel in ipairs(files) do
    local f, err = SMODS.load_file(rel)
    if not f then
        print("Error loading item file '"..rel.."': "..tostring(err))
    else
        local ok, curr_obj = pcall(f)
        if ok then
            table.insert(objects, curr_obj)
        end
    end
end

table.sort(objects, function(a, b)
    local function get_lowest_order(obj)
        if not obj.items then return math.huge end
        local lowest = math.huge
        for _, item in ipairs(obj.items) do
            if item.order and item.order < lowest then
                lowest = item.order
            end
        end
        return lowest
    end
    return get_lowest_order(a) < get_lowest_order(b)
end)

for _, curr_obj in ipairs(objects) do
    load_items(curr_obj)
end

local game_main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
    local ret = game_main_menu_ref(self, change_context)
    G.SPLASH_BACK:define_draw_steps({
        {
            shader = "splash",
            send = {
                { name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", val = 0.4 },
                { name = "colour_1", ref_table = G.C.BalatroInscrybed, ref_value = "DARK_ORANGE" },
                { name = "colour_2", ref_table = G.C, ref_value = "BLACK" },
            },
        },
    })
    return ret
end

SMODS.Gradient {
    key = 'leshy',
    colours = {HEX("1e5e2c"), HEX("2c6638"), HEX("3b7748")},
    cycle = 5
}
SMODS.Gradient {
    key = 'po3',
    colours = {HEX("3cb4ff"), HEX("009cfd"), HEX("5ecefe")},
    cycle = 5
}
SMODS.Gradient {
    key = 'grimora',
    colours = {HEX("748d67"), HEX("839689"), HEX("86a367")},
    cycle = 5
}
SMODS.Gradient {
    key = 'magnificus',
    colours = {HEX("9af8e2"), HEX("ff5aee"), HEX("fee9c6")},
    cycle = 10
}

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
    key = 'selected_scribe',
    order = 10,
    func = function(self)
        if G.GAME.selected_scrybe ~= "" and self.area == G.deck then
            local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            G.shared_insc_scribes[G.GAME.selected_scrybe].role.draw_major = self
            G.shared_insc_scribes[G.GAME.selected_scrybe]:draw_shader('dissolve', nil, nil, true, self.children.center, 0.25*scale_mod, 0, nil, -0.1)
        end
    end,
    conditions = { vortex = false, facing = 'back' },
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
        G.shared_insc_scribes["Leshy"] = Sprite(0,0,G.CARD_W,G.CARD_H,G.ASSET_ATLAS["insc_scribe_backs"], {x=0,y=0})
        G.shared_insc_scribes["PO3"] = Sprite(0,0,G.CARD_W,G.CARD_H,G.ASSET_ATLAS["insc_scribe_backs"], {x=1,y=0})
        G.shared_insc_scribes["Grimora"] = Sprite(0,0,G.CARD_W,G.CARD_H,G.ASSET_ATLAS["insc_scribe_backs"], {x=0,y=1})
        G.shared_insc_scribes["Magnificus"] = Sprite(0,0,G.CARD_W,G.CARD_H,G.ASSET_ATLAS["insc_scribe_backs"], {x=1,y=1})
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
