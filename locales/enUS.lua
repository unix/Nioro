local addonName = GetAddOnMetadata(..., 'Title')
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

L['ADDON_SHOW_NAME'] = 'Nioro'
L['SLASH_TIPS_SHOW'] = 'Show Setting Planel'
L['SLASH_TIPS_VERSION'] = 'Show Version'
L['NOT_FOUND_RAID_FRAME'] = 'Did not found raid frame, you need enable Blizzard raid frame.'
L['SETTINGS_BASE_NAME'] = 'General'
L['SETTINGS_BASE_HANDER'] = 'General Setting'
L['SETTINGS_BASE_SHOWROLE'] = 'Enable Role Icon'
L['SETTINGS_BASE_SHOWNAME'] = 'Enable Unit Name'
L['SETTINGS_BASE_SHORT_NAME'] = 'Abbreviate Long Names'
L['SETTINGS_BASE_SHORT_PERC'] = 'Hide Percent sign (%) in PERC Mode'
L['SETTINGS_BASE_FLAT_TEXTURE'] = 'Use Flat Texture on Health Bar'
L['SETTINGS_BASE_FLAT_ICON'] = 'Use Flat Style on Aura Icon'
L['SETTINGS_BASE_BUFF_TOOLTIP'] = 'Hide Buff Tooltip'
L['SETTINGS_BASE_DEBUFF_TOOLTIP'] = 'Hide Debuff Tooltip'
L['SETTINGS_BASE_GROUP_NAME'] = 'Hide Group Number in Group by party Mode'

L['SETTINGS_RESIZE_NAME'] = 'Frame Setting'
L['SETTINGS_RESIZE_HANDER'] = 'Frame Setting'
L['SETTINGS_RESIZE_BUFF'] = 'Buff Icon Scale'
L['SETTINGS_RESIZE_DEBUFF'] = 'Debuff Icon Scale'
L['SETTINGS_RESIZE_FRAME'] = 'Raid Frame Scale'
L['SETTINGS_FONT_NAME'] = 'Font Setting'
L['SETTINGS_FONT_HANDER'] = 'Font Setting'
L['SETTINGS_FONT_NAME_SIZE'] = 'Unit Name Font Scale'
L['SETTINGS_FONT_STATUS_SIZE'] = 'Status Text Font Scale'
L['MIORO_RELOAD_CONFIRM'] = '[Nioro]: The Setting you changed require an UI reload. Do you want to reload immediately?'
L['SETTINGS_INFO_DESC'] = 'Nioro can make your Blizzard Compact Raid Frame better.'

