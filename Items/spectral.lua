SMODS.Consumable {
	set = "Spectral",
	name = "Sigilapplyfec",
	key = "sigilapplyfec",
	order = 8,
	config = {
		-- This will add a tooltip.
		mod_conv = "digger",
		-- Tooltip args
		sigil = { odds = 4 },
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		-- Handle creating a tooltip with set args.
		info_queue[#info_queue + 1] =
			{ set = "Other", key = "insc_"..self.config.mod_conv.."_sigil", specific_vars = {G.GAME.probabilities.normal, self.config.sigil.odds } }
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 0, y = 0 },
	use = function(self, card, area, copier) --Good enough
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			local highlighted = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if highlighted then
						highlighted:set_sigil("insc_"..card.ability.mod_conv)
					end
					return true
				end,
			}))
		end
		for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();G.hand:unhighlight_all();return true end }))
        end
	end,
}
SMODS.Consumable {
	set = "Spectral",
	name = "Sigilapplygibe",
	key = "sigilapplygibe",
	order = 8,
	config = {
		-- This will add a tooltip.
		mod_conv = "buff_powered",
		-- Tooltip args
		sigil = { },
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		-- Handle creating a tooltip with set args.
		info_queue[#info_queue + 1] =
			{ set = "Other", key = "insc_"..self.config.mod_conv.."_sigil", specific_vars = { } }
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 1, y = 0 },
	use = function(self, card, area, copier) --Good enough
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			local highlighted = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if highlighted then
						highlighted:set_sigil("insc_"..card.ability.mod_conv)
					end
					return true
				end,
			}))
		end
		for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();G.hand:unhighlight_all();return true end }))
        end
	end,
}
SMODS.Consumable {
	set = "Spectral",
	name = "Sigilapplyove",
	key = "sigilapplyove",
	order = 8,
	config = {
		-- This will add a tooltip.
		mod_conv = "gemconduit",
		-- Tooltip args
		sigil = { x_mult = 2, odds = 2 },
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		-- Handle creating a tooltip with set args.
		info_queue[#info_queue + 1] =
			{ set = "Other", key = "insc_"..self.config.mod_conv.."_sigil", specific_vars = { self.config.sigil.x_mult, G.GAME.probabilities.normal or 1, self.config.sigil.odds } }
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 4,
	atlas = "spectrals",
	pos = { x = 2, y = 0 },
	use = function(self, card, area, copier) --Good enough
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			local highlighted = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if highlighted then
						highlighted:set_sigil("insc_"..card.ability.mod_conv)
					end
					return true
				end,
			}))
		end
		for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();G.hand:unhighlight_all();return true end }))
        end
	end,
}