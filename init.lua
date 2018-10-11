local addon = LibStub('AceAddon-3.0'):NewAddon('Nioro')
local Init = addon:NewModule('Init')

function Init:vars()
    if not NIORO_VARS then NIORO_VARS = {} end
    if not _G then _G = {} end
    NIORO_VARS.COMPACT_UNIT_FRAME = false
end

function Init:DB()
    if not NIORO_DB then NIORO_DB = {} end
    if not NIORO_DB.SETTINGS then 
        NIORO_DB.SETTINGS = {
            BUFF_SCALE = 1,
            DEBUFF_SCALE = 1,
            USE_FLAT_TEXTURE = true,
            USE_FLAT_ICON = true,
            OPTIONS = {
                displayName = true,
                displayRoleIcon = true,
            },
        }
    end
end

function Init:OnInitialize()
    self:vars()
    self:DB()
end


