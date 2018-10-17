local addonName = GetAddOnMetadata(..., 'Title')
local addonVersion = GetAddOnMetadata(..., 'Version')
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local Constants = addon:NewModule('Constants')

local infos = {
    ADDON_BASE_NAME = addonName,
    VERSION = addonVersion,
    ICON_DEFAULT_WIDTH = 17.7,
    NATIVE_UNIT_FRAME_HEIGHT = 36,
    NATIVE_UNIT_FRAME_WIDTH = 72,
    NATIVE_FONT_SIZE = 12,
}

function Constants:GetInfos()
    return infos
end
