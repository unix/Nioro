local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local Buff = addon:NewModule('SettingsBuff')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')

local separatorGenerator = function (order)
    return { name = '\n' ,type = 'description', order = order }
end

local buff = {
    buff = {
        name = L.SETTINGS_BUFF_NAME,
        type = 'group',
        order = 4,
        args = {
            buffHander = {
                name = L.SETTINGS_BUFF_HANDER,
                type = 'header',
                order = 1,
            },
            buffSep1 = { 
                name = L.SETTINGS_BUFF_DESC,
                type = 'description', 
                order = 2,
            },
            buffShowMax = {
                name = L.SETTINGS_BUFF_SHOW_BUFF_MAX,
                type = 'range',
                width = 'full',
                min = 0,
                max = 6,
                step = 1,
                order = 4,
                set = function (info, value)
                    Actions:setShowBuffNum(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.BUFF_SHOW_BUFF_MAX
                end
            },
            buffSep2 = separatorGenerator(5),
            debuffShowMax = {
                name = L.SETTINGS_BUFF_SHOW_DEBUFF_MAX,
                type = 'range',
                width = 'full',
                min = 0,
                max = 6,
                step = 1,
                order = 6,
                set = function (info, value)
                    Actions:setShowDebuffNum(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.BUFF_SHOW_DEBUFF_MAX
                end
            },
            buffSep3 = separatorGenerator(7),
            dispelDebuffShowMax = {
                name = L.SETTINGS_BUFF_SHOW_DISPEL_DEBUFF_MAX,
                type = 'range',
                width = 'full',
                min = 0,
                max = 6,
                step = 1,
                order = 8,
                set = function (info, value)
                    Actions:setShowDispelDebuffNum(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.BUFF_SHOW_DISPEL_DEBUFF_MAX
                end
            },
            buffSep4 = separatorGenerator(9),
            buffReload = {
                name = L.SETTINGS_BUFF_RELOAD_BTN,
                type = 'execute',
                width = 'full',
                order = 10,
                func = function (info)
                    ReloadUI()
                end
            },
        },
    },
}

function Buff:get()
    return buff
end

function Buff:OnInitialize()
end
