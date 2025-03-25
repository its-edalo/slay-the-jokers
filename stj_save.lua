STJ_VERSION = "0.1"

function encode_card(card)
    local data = {}
    local name = card.ability.name
    local is_modded = false
    local desc_args = nil

    if card:is_modded() then
        is_modded = true
        local localization_set = G.localization.descriptions[card.ability.set]
        if localization_set and card.config.center_key then
            local localization_desc = localization_set[card.config.center_key]
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

    if card.facing and card.facing =='back' then
        name = "?"
    else
        desc_args = card:get_description_table(is_modded)
    end

    -- name
    data.n = name
    -- position and size
    data.x = string.format("%.3f", 5.4 + card.T.x * 4.4)
    data.y = string.format("%.3f", 4 + card.T.y * 7.822)
    data.w = string.format("%.3f", card.T.w * 4.4)
    data.h = string.format("%.3f", card.T.h * 7.822)

    -- popup direction
    data.p = card:get_popup_direction()

    -- description
    data.d = desc_args

    -- modded
    if (is_modded) then
        data.m = 1
    end

    return data
end

function Game:stj_save()
    if not G.last_stj_save or G.TIMERS.UPTIME - G.last_stj_save > 0.5 then
        G.last_stj_save = G.TIMERS.UPTIME

        local live_data = {}
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
                        table.insert(card_data, encode_card(v))
                    end
                end
            end
        end

        live_data.v = STJ_VERSION
        live_data.c = card_data

        G.STJ_MANAGER.channel:push({
            type = 'save_stj_data',
            card_data = json.encode(live_data)})
    end
end