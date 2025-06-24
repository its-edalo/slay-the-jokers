STJ_VERSION = "0.2"
MAX_ENCODED_CARDS_PER_SOURCE = 50

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

function get_card_stickers(card)
    local stickers = {}

    -- perishanle
    if (card.ability.perishable) then
        stickers["p"] = card.ability.perish_tally
    end

    -- rental
    if (card.ability.rental) then
        stickers["r"] = 1
    end

    -- eternal
    if (card.ability.eternal) then
        stickers["e"] = 1
    end

    return stickers
end

function get_card_edition(card)
    if not card.edition then
        return nil
    end

    if card.edition.holo then
        return "h"
    elseif card.edition.foil then
        return "f"
    elseif card.edition.polychrome then
        return "p"
    elseif card.edition.negative then
        if card.ability.consumeable then
            return "nc"
        else
            return "n"
        end
    end

    return nil
end

function encode_card(card)
    local data = {}
    local name = nil

    if not is_encodable(card) then
        return nil
    end

    if card.facing and card.facing =='back' then
        name = "?"
    else
        name = card.ability.name

        if name == "Riff-raff" then
            name = "Riff-Raff"
        elseif name == "Caino" then
            name = "Canio"
        end

        local stickers = get_card_stickers(card)

        if stickers and next(stickers) then
            -- stickers
            data.s = stickers
        end

        local edition = get_card_edition(card)
        if edition then
            -- edition
            data.e = edition
        end

        if (card:is_modded()) then
            -- modded
            data.m = 1

            local localization_set = G.localization.descriptions[card.ability.set]
            if localization_set and card.config.center_key then
                local localization_desc = localization_set[card.config.center_key]
                if localization_desc and localization_desc.name then
                    name = localization_desc.name
                end
            end

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
            -- description
            data.d = card:get_description_table(true)
        else
            -- description
            data.d = card:get_description_table(false)
        end
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

    return data
end


function get_roffle_card()
    local data = {}
    local name = "Roffle"

    data.m = 1
    data.r = "Legendary"

    data.d = {["p"] = {{["t"] = "Aloo"}}}

    data.n = name
    data.x = string.format("%.3f", 1530 / 1920 * 100)
    data.y = string.format("%.3f", 260 / 1080 * 100)
    data.w = string.format("%.3f", 365 / 1920 * 100)
    data.h = string.format("%.3f", 465 / 1080 * 100)

    data.p = 'b'

    return data
end

function can_get_run_info()
    return G.GAME and G.GAME.hands
end

function get_run_info()
    local run_info = {}
    local possible_hands = {
        "High Card",
        "Pair",
        "Two Pair",
        "Three of a Kind",
        "Straight",
        "Flush",
        "Full House",
        "Four of a Kind",
        "Straight Flush",
        "Five of a Kind",
        "Flush House",
        "Flush Five"
    }

    run_info.h = {}

    for index, handname in ipairs(possible_hands) do
        local hand = G.GAME.hands[handname]
        if hand and hand.visible then
            run_info.h[index] = {
                ["l"] = hand.level,
                ["c"] = hand.chips,
                ["m"] = hand.mult,
                ["p"] = hand.played
            }
        end
    end

    return run_info
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
        if G.your_collection then
            for i, card_line in ipairs(G.your_collection) do
                card_sources["collection_line" .. i] = card_line
            end
        end

        local unsaved_card_sets = {Back = true, Default = true, Enhanced = true, Edition = true, Seal = true, Other = true}

        for _, source in pairs(card_sources) do
            if source and source.cards then
                local encoded_count = 0
                for _, v in pairs(source.cards) do
                    if encoded_count >= MAX_ENCODED_CARDS_PER_SOURCE then
                        break
                    end
                    if v.ability and not unsaved_card_sets[v.ability.set] then
                        local encoded_card = encode_card(v)
                        if encoded_card then
                            table.insert(card_data, encoded_card)
                            encoded_count = encoded_count + 1
                        end
                    end
                end
            end
        end

        local roffle_card = get_roffle_card()
        if roffle_card then
            table.insert(card_data, roffle_card)
        end

        live_data.v = STJ_VERSION
        live_data.c = card_data

        -- if can_get_run_info() then
        --     local run_info = get_run_info()
        --     if run_info then
        --         live_data.r = run_info
        --     end
        -- end

        G.STJ_MANAGER.channel:push({
            type = 'save_stj_data',
            card_data = json.encode(live_data)})
    end
end
