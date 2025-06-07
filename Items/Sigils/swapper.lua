local swapper = {
    object_type = "Sigil",
    name = "insc_Swapper",
    key = "swapper",
    badge_colour = HEX("9fff80"),
    config = {},
    atlas = 'sigils',
    atlas_extra = 'sigilsextra',
    pos = {x=0, y=6},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.before then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('insc_swap'), colour = G.C.PURPLE })
            local chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"nominal"}, false, true, "base")
            local mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "base")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            local chip_map = {
                chip_mod = "mult_mod",
                h_chips = "h_mult",
            }

            local chip_keys, mult_keys = {}, {}
            for chip, mult in pairs(chip_map) do
                table.insert(chip_keys, chip)
                table.insert(mult_keys, mult)
            end

            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, chip_keys, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, mult_keys, false, true, "ability.extra")

            for i, chip in ipairs(chip_keys) do
                local mult = chip_map[chip]

                if chips[i] and mult then
                    local m_val = m_value[i] ~= nil and m_value[i] or (m_value[#m_value] or 0)
                    local c_val = c_value[i] ~= nil and c_value[i] or (c_value[#c_value] or 0)

                    if chips[i] then
                        insc_ability_calculate(card, "=", m_val, nil, {chips[i]}, false, true, "ability.extra")
                    end
                    if mult then
                        insc_ability_calculate(card, "=", c_val, nil, {mult}, false, true, "ability.extra")
                    end
                end
            end
            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_bonus"}, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "/", 2, nil, {mult[1]}, false, true, "ability.extra")
        end
        if context.final_scoring_step then
            local chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"nominal"}, false, true, "base")
            local mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "base")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            local chip_map = {
                chip_mod = "mult_mod",
                h_chips = "h_mult",
            }

            local chip_keys, mult_keys = {}, {}
            for chip, mult in pairs(chip_map) do
                table.insert(chip_keys, chip)
                table.insert(mult_keys, mult)
            end

            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, chip_keys, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, mult_keys, false, true, "ability.extra")

            for i, chip in ipairs(chip_keys) do
                local mult = chip_map[chip]

                if chips[i] and mult then
                    local m_val = m_value[i] ~= nil and m_value[i] or (m_value[#m_value] or 0)
                    local c_val = c_value[i] ~= nil and c_value[i] or (c_value[#c_value] or 0)

                    if chips[i] then
                        insc_ability_calculate(card, "=", m_val, nil, {chips[i]}, false, true, "ability.extra")
                    end
                    if mult then
                        insc_ability_calculate(card, "=", c_val, nil, {mult}, false, true, "ability.extra")
                    end
                end
            end
            chips, c_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_bonus"}, false, true, "ability.extra")
            mult, m_value = insc_ability_get_items(card, "nil", 2, { extra_value = true }, {"perma_mult"}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", m_value[1], nil, {chips[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "=", c_value[1], nil, {mult[1]}, false, true, "ability.extra")
            insc_ability_calculate(card, "*", 2, nil, {chips[1]}, false, true, "ability.extra")
        end
    end
}
return {name = {"Sigils"}, items = {swapper}}