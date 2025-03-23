function Game:stj_save()
    if not G.last_stj_save or G.TIMERS.UPTIME - G.last_stj_save > 0.5 then
        G.last_stj_save = G.TIMERS.UPTIME

        local card_data = {}
        local card_sources = {
            jokers = G.jokers,
            consumeables = G.consumeables,
            shop_jokers = G.shop_jokers,
            pack_cards = G.pack_cards,
            shop_vouchers = G.shop_vouchers,
        }
        -- if G.your_collection then
            -- for i, card_line in ipairs(G.your_collection) do
                -- card_sources["collection_line" .. i] = card_line
            -- end
        -- end

        local unsaved_card_sets = {Back = true, Default = true, Enhanced = true, Edition = true, Seal = true, Other = true}

        for _, source in pairs(card_sources) do
            if source and source.cards then
                for _, v in pairs(source.cards) do
                    if v.ability and not unsaved_card_sets[v.ability.set] then
                        local name = v.ability.name
                        local is_modded = false

                        if v:is_modded() then
                            is_modded = true
                            local localization_set = G.localization.descriptions[v.ability.set]
                            if localization_set then
                                local localization_desc = localization_set[v.ability.name]
                                if localization_desc and localization_desc.name then
                                    name = localization_desc.name
                                end
                            end
                        end

                        if name == "Riff-raff" then
                            name = "Riff-Raff"
                        elseif name == "Caino" then
                            name = "Canio"
                        end

                        local x = string.format("%.3f", v.T.x)
                        local y = string.format("%.3f", v.T.y)
                        local w = string.format("%.3f", v.T.w)
                        local h = string.format("%.3f", v.T.h)
                        local popup_direction = v:get_popup_direction()
                        local desc_args = nil

                        if v.facing and v.facing =='back' then
                            name = "?"
                        else
                            desc_args = v:get_desc_args(is_modded)
                        end
                        
                        if not desc_args or #desc_args == 0 then
                            table.insert(card_data, string.format("%s,%s,%s,%s,%s,%s", name, x, y, w, h, popup_direction))
                        else
                            local desc_args_str = table.concat(desc_args, ",")
                            table.insert(card_data, string.format("%s,%s,%s,%s,%s,%s,%s", name, x, y, w, h, popup_direction, desc_args_str))
                        end
                    end
                end
            end
        end
            
        G.STJ_MANAGER.channel:push({
            type = 'save_stj_data',
            card_data = table.concat(card_data, "\n")})
    end
end