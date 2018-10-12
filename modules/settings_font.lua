local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local Font = addon:NewModule('SettingsFont')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')

local separatorGenerator = function (order)
    return { name = '\n' ,type = 'description', order = order }
end

local font = {
    font = {
        name = '字体调整',
        type = 'group',
        order = 2,
        args = {
            fontHander = {
                name = '字体调整',
                type = 'header',
                order = 1,
            },
            fontSep1 = separatorGenerator(2),
            fontNameSize = {
                name = '姓名文字大小',
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.1,
                order = 3,
                set = function (info, value)
                    print(123, value)
                    Actions:setFontNameScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.FONT_NAME_SCALE
                end
            },
            fontSep2 = separatorGenerator(4),
            fontStatusSize = {
                name = '状态文字缩放',
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.1,
                order = 5,
                set = function (info, value)
                    Actions:setFontStatusScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.FONT_STATUS_SCALE
                end
            },
        },
    },
}

function Font:get()
    return font
end

function Font:OnInitialize()
end
