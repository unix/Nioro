local addonName = GetAddOnMetadata(..., 'Title')
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN", false)
if not L then return end

L['ADDON_SHOW_NAME'] = 'Nioro'
L['SLASH_TIPS_SHOW'] = '显示配置面板'
L['SLASH_TIPS_VERSION'] = '显示版本'
L['NOT_FOUND_RAID_FRAME'] = '未找到团队框架，请启用原生团队框架。'
L['SETTINGS_BASE_NAME'] = '基础设置'
L['SETTINGS_BASE_HANDER'] = '基础设置'
L['SETTINGS_BASE_SHOWROLE'] = '显示职责图标'
L['SETTINGS_BASE_SHOWNAME'] = '显示姓名'
L['SETTINGS_BASE_SHORT_NAME'] = '简写姓名'
L['SETTINGS_BASE_SHORT_PERC'] = '隐藏百分比符号 (当百分比显示生命值时)'
L['SETTINGS_BASE_FLAT_TEXTURE'] = '扁平化显示生命值'
L['SETTINGS_BASE_FLAT_ICON'] = '扁平化显示图标\n'
L['SETTINGS_BASE_BUFF_TOOLTIP'] = '隐藏 BUFF 详情提示框'
L['SETTINGS_BASE_DEBUFF_TOOLTIP'] = '隐藏 DEBUFF 详情提示框'
L['SETTINGS_BASE_GROUP_NAME'] = '隐藏小队名称 (仅在小队相连模式有效)'

L['SETTINGS_RESIZE_NAME'] = '框架缩放'
L['SETTINGS_RESIZE_HANDER'] = '框架缩放'
L['SETTINGS_RESIZE_BUFF'] = 'Buff 大小调整'
L['SETTINGS_RESIZE_DEBUFF'] = 'Debuff 大小调整'
L['SETTINGS_RESIZE_FRAME'] = '缩放团队框架框体大小'
L['SETTINGS_FONT_NAME'] = '字体调整'
L['SETTINGS_FONT_HANDER'] = '字体调整'
L['SETTINGS_FONT_NAME_SIZE'] = '姓名文字缩放'
L['SETTINGS_FONT_STATUS_SIZE'] = '状态文字缩放'
L['MIORO_RELOAD_CONFIRM'] = '[Nioro]: 改动此设置项需要重新加载 UI 界面，你确定吗 ?'
L['SETTINGS_INFO_DESC'] = 'Nioro 能帮助你详细设定暴雪原生框架界面。使用前请确认团队框架已勾选使用。'


