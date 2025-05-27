STJ_VERSION = "0.1.3b"

function can_stj_save()
    if not G.ROOM or not G.ROOM.T or not G.ROOM.T.x or not G.ROOM.T.y then
        return false
    end

    if not G.TILESCALE or not G.TILESIZE then
        return false
    end

    return true
end

function is_encodable(card)
    if not card.ability or not card.ability.name or not card.ability.set then
        return false
    end

    if not card.config or not card.config.center or not card.config.center_key then
        return false
    end

    if not card.children then
        return false
    end

    if not card.T or card.T.x == nil or card.T.y == nil or card.T.w == nil or card.T.h == nil then
        return false
    end

    return true
end

function get_encoded_card_positions(card, game_width, game_height)
    -- Options: "TOP", "CENTER", "CROPPED_CENTER"
    local STREAM_POSITION = "CENTER"

    local x_stream_alignment_offset = 0
    local y_stream_alignment_offset = -0.05

    local screen_scale = G.TILESCALE * G.TILESIZE
    local x_to_percent_factor = 100 * screen_scale / game_width
    local y_to_percent_factor = 100 * screen_scale / game_height

    local unscaled_x = x_to_percent_factor * (card.T.x + G.ROOM.T.x + x_stream_alignment_offset)
    local unscaled_y = y_to_percent_factor * (card.T.y + G.ROOM.T.y + y_stream_alignment_offset)
    local unscaled_w = x_to_percent_factor * card.T.w
    local unscaled_h = y_to_percent_factor * card.T.h

    local x, y, w, h

    if STREAM_POSITION == "CROPPED_CENTER" then
        local stream_width_scaler = (game_width / game_height) * (1080 / 1920)
        local scaled_x = unscaled_x * stream_width_scaler - 100 * (stream_width_scaler - 1) / 2
        local scaled_w = unscaled_w * stream_width_scaler

        x = string.format("%.3f", scaled_x)
        y = string.format("%.3f", unscaled_y)
        w = string.format("%.3f", scaled_w)
        h = string.format("%.3f", unscaled_h)
    else
        local stream_height_scaler = (game_height / game_width) * (1920 / 1080)
        local scaled_h = unscaled_h * stream_height_scaler

        local scaled_y = unscaled_y * stream_height_scaler
        if STREAM_POSITION == "CENTER" then
            scaled_y = scaled_y + 100 * (1 - stream_height_scaler) / 2
        end

        x = string.format("%.3f", unscaled_x)
        y = string.format("%.3f", scaled_y)
        w = string.format("%.3f", unscaled_w)
        h = string.format("%.3f", scaled_h)
    end

    return x, y, w, h
end

function encode_card(card, game_width, game_height)
    local data = {}
    local is_modded = false
    local desc_args = nil

    if not is_encodable(card) then
        return nil
    end

    local name = card.ability.name
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

        -- perishanle
        if (card.ability.perishable) then
            data.s = {["p"] = card.ability.perish_tally}
        end
    end


    -- name
    data.n = name
    -- position and size
    data.x, data.y, data.w, data.h = get_encoded_card_positions(card, game_width, game_height)

    -- popup direction
    data.p = card:get_popup_direction()

    -- description
    data.d = desc_args

    -- modded
    if (is_modded) then
        data.m = 1

        if card.ability.set == "Joker" and card.config.center.rarity then
            local rarity = card.config.center.rarity

            local card_types = {"Common", "Uncommon", "Rare", "Legendary"}
            if (card_types[rarity]) then
                data.r = card_types[rarity]
            else
                local localized_rarity = localize("k_" .. rarity:lower())
                if (localized_rarity ~= 'ERROR') then
                    data.r = localized_rarity
                end
            end
        end
    end

    return data
end

function Game:stj_save()
    if (not G.last_stj_save or G.TIMERS.UPTIME - G.last_stj_save > 0.5) and can_stj_save() then
        G.last_stj_save = G.TIMERS.UPTIME

        local game_width, game_height = love.graphics.getDimensions()

        local live_data = {}
        local card_data = {}
        local card_sources = {
            jokers = G.jokers,
            consumeables = G.consumeables,
            shop_jokers = G.shop_jokers,
            pack_cards = G.pack_cards,
            shop_vouchers = G.shop_vouchers,
        }
        if G.your_collection then
            for i, card_line in ipairs(G.your_collection) do
                card_sources["collection_line" .. i] = card_line
            end
        end

        local unsaved_card_sets = {Back = true, Default = true, Enhanced = true, Edition = true, Seal = true, Other = true}

        for _, source in pairs(card_sources) do
            if source and source.cards then
                for _, v in pairs(source.cards) do
                    if v.ability and not unsaved_card_sets[v.ability.set] then
                        local encoded_card = encode_card(v, game_width, game_height)
                        if encoded_card then
                            table.insert(card_data, encoded_card)
                        end
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
