local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local AceConfig, AceConfigDialog, AceGUI  = LibStub('AceConfig-3.0'), LibStub('AceConfigDialog-3.0'), LibStub('AceGUI-3.0')
local Menus = addon:NewModule('SettingsMenus')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')

local menus = {
    info = {
        name = L.SETTINGS_INFO_DESC,
        type = 'description',
        order = 1,
    },
    base = {
        name = L.SETTINGS_BASE_NAME,
        type = 'group',
        order = 2,
        args = {
            baseHander = {
                name = L.SETTINGS_BASE_HANDER,
                type = 'header',
                order = 1,
            },
            baseDesc = {
                name = '\n',
                type = 'description',
                order = 2,
            },
            baseRole = {
                name = L.SETTINGS_BASE_SHOWROLE,
                type = 'toggle',
                width = 'full',
                order = 3,
                tristate = true,
                get = function ()
                    return Utils:toboolean(NIORO_DB.SETTINGS.OPTIONS.displayRoleIcon)
                end,
                set = function (info, t)
                    Actions:toggleRoleIcon(Utils:toboolean(t))
                end,
            },
            baseName = {
                name = L.SETTINGS_BASE_SHOWNAME,
                type = 'toggle',
                width = 'full',
                order = 4,
                tristate = true,
                get = function ()
                    return Utils:toboolean(NIORO_DB.SETTINGS.OPTIONS.displayName)
                end,
                set = function (info, t)
                    Actions:toggleMemberName(Utils:toboolean(t))
                end,
            },
            baseFlatTexture = {
                name = L.SETTINGS_BASE_FLAT_TEXTURE,
                type = 'toggle',
                width = 'full',
                order = 5,
                tristate = true,
                get = function ()
                    return Utils:toboolean(NIORO_DB.SETTINGS.USE_FLAT_TEXTURE)
                end,
                set = function (info, t)
                    Actions:toggleFlatTexture(Utils:toboolean(t))
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
                    StaticPopup_Show('MIORO_RELOAD_CONFIRM')
                end,
            },
            baseFlatIcon = {
                name = L.SETTINGS_BASE_FLAT_ICON,
                type = 'toggle',
                width = 'full',
                order = 6,
                tristate = true,
                get = function ()
                    return Utils:toboolean(NIORO_DB.SETTINGS.USE_FLAT_ICON)
                end,
                set = function (info, t)
                    Actions:toggleFlatIcon(Utils:toboolean(t))
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
                    StaticPopup_Show('MIORO_RELOAD_CONFIRM')
                end,
            },
            baseSep1 = {
                name = '\n',
                type = 'description',
                order = 7,
            },
            baseBuff = {
                name = L.SETTINGS_BASE_FLAT_BUFF,
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.2,
                order = 8,
                set = function (info, value)
                    Actions:setBuffScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.BUFF_SCALE
                end
            },
            baseSep2 = {
                name = '\n',
                type = 'description',
                order = 9,
            },
            baseDebuff = {
                name = L.SETTINGS_BASE_FLAT_DEBUFF,
                type = 'range',
                width = 'full',
                min = 0.5,
                max = 3,
                step = 0.2,
                order = 10,
                set = function (info, value)
                    Actions:setDebuffScale(value)
                end,
                get = function ()
                    return NIORO_DB.SETTINGS.DEBUFF_SCALE
                end
            },
        },
    },
}

function Menus:getMenus()
    return menus
end

function Menus:OnInitialize()
    StaticPopupDialogs['MIORO_RELOAD_CONFIRM'] = {
        text = L.MIORO_RELOAD_CONFIRM,
        button1 = OKAY,
        button2 = NO,
        hideOnEscape = true,
        timeout = 0,
        exclusive = true,
        showAlert = true,
        OnAccept = function(self)
            PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
            ReloadUI()
        end,
        OnCancel = function(self)
            PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
            StaticPopup_Hide('MIORO_RELOAD_CONFIRM')
        end,
    }
end
