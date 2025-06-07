local campfire = {
    object_type = "insc_Event",
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
return {name = {"Events"}, items = {campfire}}