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
                -- baseDesc = separatorGenerator(2),
                baseRole = {
                    name = L.SETTINGS_BASE_SHOWROLE,
                    type = 'toggle',
                    width = 'full',
                    order = 3,
                    tristate = true,
                    get = function (info)
                        info.options.args.base.args.baseVersion.name = format("|CFF00FFFF%s: |r", '\n\n[Nioro]')..'v'..infos.VERSION
                        return Utils:toboolean(NIORO_DB.SETTINGS.DISPLAY_ROLE_ICON)
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
                        return Utils:toboolean(NIORO_DB.SETTINGS.DISPLAY_NAME)
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
                    name = L.SETTINGS_BASE_BUFF_TOOLTIP,
                    type = 'toggle',
                    width = 'full',
                    order = 11,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.HIDDEN_BUFF_TOOLTIP)
                    end,
                    set = function (info, t)
                        Actions:toggleBuffTooltip(Utils:toboolean(t))
                    end,
                },
                baseDebuffTooltip = {
                    name = L.SETTINGS_BASE_DEBUFF_TOOLTIP,
                    type = 'toggle',
                    width = 'full',
                    order = 12,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.HIDDEN_DEBUFF_TOOLTIP)
                    end,
                    set = function (info, t)
                        Actions:toggleDebuffTooltip(Utils:toboolean(t))
                    end,
                },
                baseGroupName = {
                    name = L.SETTINGS_BASE_GROUP_NAME,
                    type = 'toggle',
                    width = 'full',
                    order = 13,
                    tristate = true,
                    get = function ()
                        return Utils:toboolean(NIORO_DB.SETTINGS.HIDDEN_GROUP_NAME)
                    end,
                    set = function (info, t)
                        Actions:toggleGroupName(Utils:toboolean(t))
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


function Menus:OnInitialize()
end
