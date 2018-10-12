local addon = LibStub('AceAddon-3.0'):NewAddon('Nioro')
local Init = addon:NewModule('Init')

function Init:vars()
    if not NIORO_VARS then NIORO_VARS = {} end
    if not _G then _G = {} end
    NIORO_VARS.COMPACT_UNIT_FRAME = false
    NIORO_VARS.COMPACT_FRAME = {}
end

function Init:DB()
    if not NIORO_DB then NIORO_DB = {} end
    if (not NIORO_DB.SETTINGS) 
    or (not NIORO_DB.SETTINGS.VERSION) 
    or (NIORO_DB.SETTINGS.VERSION < self.DBVERSION) then
        NIORO_DB.SETTINGS = {
            VERSION = self.DBVERSION,
            BUFF_SCALE = 1,
            DEBUFF_SCALE = 1,
            FRAME_SCALE = 1,
            USE_FLAT_TEXTURE = true,
            USE_FLAT_ICON = true,
            USE_SHORT_NAME = true,
            USE_SHORT_PERC = false,
            OPTIONS = {
                displayName = true,
                displayRoleIcon = true,
            },
        }
    end
end

function Init:OnInitialize()
    self.DBVERSION = 2
    self:vars()
    self:DB()
end


