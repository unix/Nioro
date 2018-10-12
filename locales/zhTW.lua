local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):NewLocale('Nioro', "zhTW", false)
if not L then return end

L['ADDON_SHOW_NAME'] = 'Nioro'
L['SLASH_TIPS_SHOW'] = '顯示配置界面'
L['SLASH_TIPS_VERSION'] = '顯示版本'
L['NOT_FOUND_RAID_FRAME'] = '未找到團隊框架，請確認啓用暴雪原生團隊框架。'
L['SETTINGS_BASE_NAME'] = '基礎設置'
L['SETTINGS_BASE_HANDER'] = '基礎設置'
L['SETTINGS_BASE_SHOWROLE'] = '顯示職責圖標'
L['SETTINGS_BASE_SHOWNAME'] = '顯示姓名'
L['SETTINGS_BASE_SHORT_NAME'] = '簡寫姓名'
L['SETTINGS_BASE_SHORT_PERC'] = '隱藏百分比符號 (當百分比顯示生命值時)'
L['SETTINGS_BASE_FLAT_TEXTURE'] = '扁平化顯示生命值'
L['SETTINGS_BASE_FLAT_ICON'] = '扁平化顯示圖標\n'

L['SETTINGS_RESIZE_NAME'] = '縮放调整'
L['SETTINGS_RESIZE_HANDER'] = '縮放调整'
L['SETTINGS_RESIZE_BUFF'] = 'Buff 縮放'
L['SETTINGS_RESIZE_DEBUFF'] = 'Debuff 縮放'
L['SETTINGS_RESIZE_FRAME'] = '縮放團隊框架框體大小'
L['MIORO_RELOAD_CONFIRM'] = '[Nioro]: 改動此項設置必須要重新加載 UI 界面，你確定這樣做嗎 ?'
L['SETTINGS_INFO_DESC'] = 'Nioro 能幫助你詳細設定暴雪原生框架界面，使用前請先確認團隊框架已勾選使用。'
