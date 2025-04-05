BalatroInscrybed.insc_Event = SMODS.GameObject:extend {
    obj_table = BalatroInscrybed.insc_Events,
    obj_buffer = {},
    required_params = {
        'key',
    },
    discovered = false,
    min_ante = nil,
    atlas = 'insc_events',
    class_prefix = 'ev',
    set = 'insc_Event',
    pos = { x = 0, y = 0 },
    config = {},
    get_obj = function(self, key) return G.P_INSC_EVENTS[key] end,
    process_loc_text = function(self)
        SMODS.process_loc_text(G.localization.descriptions.insc_Event, self.key, self.loc_txt)
    end,
    inject = function(self)
        G.P_INSC_EVENTS[self.key] = self
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
    end,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if not full_UI_table then 
            first_pass = true
            full_UI_table = {
                main = {},
                info = {},
                type = {},
                name = nil,
                badges = badges or {}
            }
        end
        local desc_nodes = desc_nodes or (not full_UI_table.name and full_UI_table.main) or full_UI_table.info
        if not card then
            card = { config = copy_table(self.config), fake_tag = true}
        end
        local target = {
            type = 'descriptions',
            key = self.key,
            set = self.set,
            nodes = desc_nodes,
            vars = specific_vars
        }
        local res = {}
        if self.loc_vars and type(self.loc_vars) == 'function' then
            -- card is actually a `Tag` here
            res = self:loc_vars(info_queue, card) or {}
            target.vars = res.vars or target.vars
            target.key = res.key or target.key
            target.set = res.set or target.set
            target.scale = res.scale
            target.text_colour = res.text_colour
        end
        if desc_nodes == full_UI_table.main and not full_UI_table.name then
            full_UI_table.name = localize { type = 'name', set = target.set, key = res.name_key or target.key, nodes = full_UI_table.name, vars = res.name_vars or res.vars or {} }
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
        _size = 0.6

        local event_sprite_tab = nil

        local event_sprite = Sprite(0,0,_size*1,_size*1,G.ASSET_ATLAS["insc_events"], self.pos)
        event_sprite.T.scale = 1
        event_sprite_tab = {n= G.UIT.C, config={align = "cm", ref_table = self, group = self.tally}, nodes={
            {n=G.UIT.O, config={w=_size*1,h=_size*1, colour = G.C.BLUE, object = event_sprite, focus_with_object = true}},
        }}
        event_sprite:define_draw_steps({
            {shader = 'dissolve', shadow_height = 0.05},
            {shader = 'dissolve'},
        })
        event_sprite.float = true
        event_sprite.states.hover.can = true
        event_sprite.states.drag.can = false
        event_sprite.states.collide.can = true

        event_sprite:juice_up()
        self.event_sprite = event_sprite

        return event_sprite_tab, event_sprite
    end,
    get_uibox_table = function(self, event_sprite)
        event_sprite = event_sprite or self.event_sprite
        local name_to_check, loc_vars = self.name, {}
        event_sprite.ability_UIBox_table = generate_card_ui(G.P_INSC_EVENTS[self.key], nil, loc_vars, (self.hide_ability) and 'Undiscovered' or 'insc_Event', nil, (self.hide_ability))
        return event_sprite
    end
}

BalatroInscrybed.insc_Event { 
    name = "insc_Sacrifice",
    key = "sacrifice",
    config = {},
    atlas = 'insc_events',
    pos = {x=0, y=0},
    disabled = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}

BalatroInscrybed.insc_Event { 
    name = "insc_Campfire",
    key = "campfire",
    config = {},
    atlas = 'insc_events',
    disabled = true,
    pos = {x=1, y=0},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}