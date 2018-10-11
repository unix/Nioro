local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local Constants = addon:NewModule('Constants')

local infos = {
    ADDON_BASE_NAME = 'Nioro',
    VERSION = '0.1.0',
    HEALTH_BAR_TEXTURE = 'Interface\\AddOns\\Nioro\\media\\Raid',
    ICON_DEFAULT_WIDTH = 17.7,
}

function Constants:GetInfos()
    return infos
end
