local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local Resize = addon:NewModule('SettingsResize')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')

local separatorGenerator = function (order)
    return { name = '\n' ,type = 'description', order = order }
end

local resize = {
    resize = {
        name = '大小调整',
        type = 'group',
        order = 2,
        args = {
            resizeHander = {
                name = '大小调整',
                type = 'header',
                order = 1,
            },
            resizeDesc = separatorGenerator(2),
            resizeBuff = {
                name = L.SETTINGS_BASE_FLAT_BUFF,
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.1,
                order = 3,
                set = function (info, value)
                    Actions:setBuffScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.BUFF_SCALE
                end
            },
            resizeSep1 = separatorGenerator(4),
            resizeDebuff = {
                name = L.SETTINGS_BASE_FLAT_DEBUFF,
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.1,
                order = 5,
                set = function (info, value)
                    Actions:setDebuffScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.DEBUFF_SCALE
                end
            },
            resizeSep2 = separatorGenerator(6),
            resizeFrame = {
                name = '缩放框架框体大小',
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.1,
                order = 7,
                set = function (info, value)
                    Actions:setFrameScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.FRAME_SCALE
                end
            },
        },
    },
}

function Resize:get()
    return resize
end

function Resize:OnInitialize()
end
