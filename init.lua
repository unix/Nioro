local addonName = GetAddOnMetadata(..., 'Title')
local addon = LibStub('AceAddon-3.0'):NewAddon(addonName)
local Init = addon:NewModule('Init')

function Init:getDefaultSettings()
    return {
        VERSION = 11,
        BUFF_SCALE = 1,
        DEBUFF_SCALE = 1,
        FRAME_SCALE = 1,
        DISPLAY_NAME = true,
        DISPLAY_ROLE_ICON = false,
        FONT_NAME_SCALE = 1,
        FONT_STATUS_SCALE = 1,
        USE_FLAT_TEXTURE = true,
        USE_FLAT_ICON = true,
        USE_SHORT_NAME = true,
        USE_SHORT_PERC = true,
        HIDDEN_BUFF_TOOLTIP = false,
        HIDDEN_DEBUFF_TOOLTIP = false,
        HIDDEN_GROUP_NAME = true,
    }
end

function Init:vars()
    if not NIORO_VARS then NIORO_VARS = {} end
    if not _G then _G = {} end
    NIORO_VARS.COMPACT_UNIT_FRAME = false
    NIORO_VARS.COMPACT_FRAME = {}
end

function Init:DB()
    if not NIORO_DB then NIORO_DB = {} end
    NIORO_DB.DEFAULT_SETTINGS = self.DEFAULT_SETTINGS
    
    if not NIORO_DB.SETTINGS then NIORO_DB.SETTINGS = self.DEFAULT_SETTINGS end
    local needUpgradeSettings = not NIORO_DB.SETTINGS.VERSION or NIORO_DB.SETTINGS.VERSION < self.DEFAULT_SETTINGS.VERSION
    if not needUpgradeSettings then return end
    for k, v in pairs(self.DEFAULT_SETTINGS) do
        if NIORO_DB.SETTINGS[k] == nil then
            NIORO_DB.SETTINGS[k] = v
        end
    end
end

function Init:OnInitialize()
    self.DEFAULT_SETTINGS = self:getDefaultSettings()
    self:vars()
    self:DB()
end


