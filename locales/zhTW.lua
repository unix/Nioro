local addonName = GetAddOnMetadata(..., 'Title')
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhTW", false)
if not L then return end

L['ADDON_SHOW_NAME'] = 'Nioro'
L['SLASH_TIPS_SHOW'] = '顯示設定界面'
L['SLASH_TIPS_VERSION'] = '顯示版本'
L['NOT_FOUND_RAID_FRAME'] = '未找到團隊框架，請確定已經啟用暴雪原生團隊框架。'
L['SETTINGS_BASE_NAME'] = '基礎設定'
L['SETTINGS_BASE_HANDER'] = '基礎設定'
L['SETTINGS_BASE_SHOWROLE'] = '顯示職責標記'
L['SETTINGS_BASE_SHOWNAME'] = '顯示姓名'
L['SETTINGS_BASE_SHORT_NAME'] = '簡寫姓名'
L['SETTINGS_BASE_SHORT_PERC'] = '以百分比顯示生命值時，隱藏百分比符號'
L['SETTINGS_BASE_FLAT_TEXTURE'] = '生命值材質扁平化'
L['SETTINGS_BASE_FLAT_ICON'] = '光環圖示扁平化'
L['SETTINGS_BASE_BUFF_TOOLTIP'] = '隱藏增益光環的提示框'
L['SETTINGS_BASE_DEBUFF_TOOLTIP'] = '隱藏減益光環的提示框'
L['SETTINGS_BASE_GROUP_NAME'] = '隱藏小隊相連模式的小隊編號'

L['SETTINGS_RESIZE_NAME'] = '縮放調整'
L['SETTINGS_RESIZE_HANDER'] = '縮放調整'
L['SETTINGS_RESIZE_BUFF'] = '增益光環縮放'
L['SETTINGS_RESIZE_DEBUFF'] = '減益光環縮放'
L['SETTINGS_RESIZE_FRAME'] = '團隊框架縮放'
L['SETTINGS_FONT_NAME'] = '字型調整'
L['SETTINGS_FONT_HANDER'] = '字型調整'
L['SETTINGS_FONT_NAME_SIZE'] = '姓名文字縮放'
L['SETTINGS_FONT_STATUS_SIZE'] = '狀態文字縮放'
L['MIORO_RELOAD_CONFIRM'] = '[Nioro]: 改動此項設定必須要重新載入 UI 界面，你確定要這樣做嗎？'
L['SETTINGS_INFO_DESC'] = 'Nioro 能幫助你詳細設定暴雪原生框架界面，使用前請先確認團隊框架已啟用。'

