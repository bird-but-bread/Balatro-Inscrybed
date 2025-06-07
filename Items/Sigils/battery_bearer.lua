local battery_bearer = {
    object_type = "Sigil",
    name = "insc_Battery_Bearer",
    key = "battery_bearer",
    badge_colour = HEX("9fff80"),
    config = { },
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=6, y=7},
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            for i = 1,#context.hand_drawn do
                if context.hand_drawn[i] == card then
                    ease_hands_played(1)
                end
            end
        end
    end
}
return {name = {"Sigils"}, items = {battery_bearer}}