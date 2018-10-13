local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local infos = addon:GetModule('Constants'):GetInfos()
local Menus = addon:NewModule('SettingsMenus')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')
local separatorGenerator = function (order)
    return { name = '\n' ,type = 'description', order = order }
end

local makeMenus = function (self)
    return {
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
                baseDesc = separatorGenerator(2),
                baseRole = {
                    name = L.SETTINGS_BASE_SHOWROLE,
                    type = 'toggle',
                    width = 'full',
                    order = 3,
                    tristate = true,
                    get = function (info)
                        info.options.args.base.args.baseVersion.name = format("|CFF00FFFF%s: |r", '\n\n[Nioro]')..'v'..infos.VERSION
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
                        self:openConfirm()
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
                        self:openConfirm()
                    end,
                },
                baseShortName = {
                    name = L.SETTINGS_BASE_SHORT_NAME,
                    type = 'toggle',
                    width = 'full',
                    order = 7,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.USE_SHORT_NAME)
                    end,
                    set = function (info, t)
                        Actions:toggleShortName(Utils:toboolean(t))
                    end,
                },
                baseShortPerc = {
                    name = L.SETTINGS_BASE_SHORT_PERC,
                    type = 'toggle',
                    width = 'full',
                    order = 8,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.USE_SHORT_PERC)
                    end,
                    set = function (info, t)
                        Actions:toggleShortPerc(Utils:toboolean(t))
                    end,
                },
                baseSep1 = separatorGenerator(10),
                baseBuffTooltip = {
                    name = '隐藏 BUFF 详情提示框',
                    type = 'toggle',
                    width = 'full',
                    order = 11,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.HIDDEN_BUFF_TOOLTIP)
                    end,
                    set = function (info, t)
                        Actions:toggleBuffTooltip(Utils:toboolean(t))
                        self:openConfirm()
                    end,
                },
                baseDebuffTooltip = {
                    name = '隐藏 DEBUFF 详情提示框',
                    type = 'toggle',
                    width = 'full',
                    order = 12,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.HIDDEN_DEBUFF_TOOLTIP)
                    end,
                    set = function (info, t)
                        Actions:toggleDebuffTooltip(Utils:toboolean(t))
                        self:openConfirm()
                    end,
                },
                baseVersion = separatorGenerator(15),
            },
        },
    }
end

function Menus:get()
    return makeMenus(self)
end

function Menus:openConfirm()
    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
    StaticPopup_Show('MIORO_RELOAD_CONFIRM')
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
