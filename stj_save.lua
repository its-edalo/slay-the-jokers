
function Game:stj_save()
    if not G.last_stj_save or G.TIMERS.UPTIME - G.last_stj_save > 0.5 then
        G.last_stj_save = G.TIMERS.UPTIME

        local card_data = {}
        local card_sources = {G.jokers, G.consumeables, G.shop_jokers, G.pack_cards}
        local saved_sets = {Joker = true, Tarot = true, Planet = true, Spectral = true}
        
        for _, source in ipairs(card_sources) do
            if source and source.cards then
                for _, v in pairs(source.cards) do
                    if v.ability and saved_sets[v.ability.set] then
                        local name = v.ability.name
                        if name == "Riff-raff" then
                            name = "Riff-Raff"
                        elseif name == "Caino" then
                            name = "Canio"
                        end

                        if v.facing and v.facing =='back' then
                            name = "?"
                        end
                        
                        local x = string.format("%.3f", v.T.x)
                        local y = string.format("%.3f", v.T.y)
                        local w = string.format("%.3f", v.T.w)
                        local h = string.format("%.3f", v.T.h)
                        local p = v:get_popup_direction()
                        local t = v:generate_locvars()
                        
                        if not t or #t == 0 then
                            table.insert(card_data, string.format("%s,%s,%s,%s,%s,%s", name, x, y, w, h, p))
                        else
                            table.insert(card_data, string.format("%s,%s,%s,%s,%s,%s,%s", name, x, y, w, h, p, table.concat(t, ",")))
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