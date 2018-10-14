local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local Actions = addon:NewModule('Actions')
local Utils = addon:GetModule('Utils')
local infos = addon:GetModule('Constants'):GetInfos()

function Actions:OnInitialize()
    self:initSlash()
    StaticPopupDialogs['MIORO_RELOAD_CONFIRM'] = {
        text = L.MIORO_RELOAD_CONFIRM,
        button1 = OKAY,
        button2 = NO,
        hideOnEscape = true,
        timeout = 0,
        exclusive = true,
        showAlert = true,
        OnAccept = function(self)
            PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
            ReloadUI()
        end,
        OnCancel = function(self)
            PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
            StaticPopup_Hide('MIORO_RELOAD_CONFIRM')
        end,
    }
end

function Actions:openConfirm()
    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
    StaticPopup_Show('MIORO_RELOAD_CONFIRM')
end

function Actions:log(text)
    local prefix = format("|CFF00FFFF%s: |r", L.ADDON_SHOW_NAME)
    SendSystemMessage(prefix..text)
end

function Actions:initSlash()
    SLASH_NIORO1 = "/nioro"
    SLASH_NIORO2 = "/NIORO"
    SLASH_NIORO3 = "/nio"
    SlashCmdList['NIORO'] = function(param)
        param = string.lower(param)
        if param == 'show' then 
            local Settings = addon:GetModule('Settings', true)
            return Settings and Settings:Open()
        end
        if param == 'version' then
            return self:log('v'..infos.VERSION)
        end
        self:log("Usage:")
        self:log('/nio show  '..L.SLASH_TIPS_SHOW)
        self:log('/nio version  '..L.SLASH_TIPS_VERSION)
    end
end

function Actions:isEnableFrame()
    local pass = Utils:tableLength(NIORO_VARS.COMPACT_FRAME) ~= 0
    -- if not pass then self:log(L.NOT_FOUND_RAID_FRAME) end
    return pass
end

function Actions:isExistsFrame(frame)
    if not frame or not frame.unit then return false end
    if not frame:IsShown() then return false end
    if UnitExists(frame.unit) then return true end
    if UnitExists(frame.displayedUnit) then return true end
    return false 
end

function Actions:updateFramePart(fn)
    if not self:isEnableFrame() then return end
    local nextFrames = {}
    for k, frame in pairs(NIORO_VARS.COMPACT_FRAME) do
        if self:isExistsFrame(frame) then 
            nextFrames[k] = frame
            fn(frame)
        end
    end
    NIORO_VARS.COMPACT_FRAME = nextFrames
    nextFrames = nil
end

function Actions:toggleRoleIcon(toggle)
    NIORO_DB.SETTINGS.DISPLAY_ROLE_ICON = toggle
    self:updateFramePart(CompactUnitFrame_UpdateRoleIcon)
end

function Actions:toggleMemberName(toggle)
    NIORO_DB.SETTINGS.DISPLAY_NAME = toggle
    self:updateFramePart(CompactUnitFrame_UpdateName)
end

function Actions:toggleFlatTexture(toggle)
    NIORO_DB.SETTINGS.USE_FLAT_TEXTURE = toggle
    self:openConfirm()
end

function Actions:toggleFlatIcon(toggle)
    NIORO_DB.SETTINGS.USE_FLAT_ICON = toggle
    self:openConfirm()
end

function Actions:toggleShortName(toggle)
    NIORO_DB.SETTINGS.USE_SHORT_NAME = toggle
    self:updateFramePart(CompactUnitFrame_UpdateName)
end

function Actions:toggleShortPerc(toggle)
    NIORO_DB.SETTINGS.USE_SHORT_PERC = toggle
    self:updateFramePart(CompactUnitFrame_UpdateStatusText)
end

function Actions:toggleBuffTooltip(toggle)
    NIORO_DB.SETTINGS.HIDDEN_BUFF_TOOLTIP = toggle
    self:openConfirm()
end

function Actions:toggleDebuffTooltip(toggle)
    NIORO_DB.SETTINGS.HIDDEN_DEBUFF_TOOLTIP = toggle
    self:openConfirm()
end

function Actions:toggleGroupName(toggle)
    NIORO_DB.SETTINGS.HIDDEN_GROUP_NAME = toggle
    self:openConfirm()
end

function Actions:setBuffScale(scale)
    NIORO_DB.SETTINGS.BUFF_SCALE = scale
    self:updateFramePart(CompactUnitFrame_UpdateBuffs)
end

function Actions:setDebuffScale(scale)
    NIORO_DB.SETTINGS.DEBUFF_SCALE = scale
    self:updateFramePart(CompactUnitFrame_UpdateDebuffs)
end

function Actions:setFrameScale(scale)
    NIORO_DB.SETTINGS.FRAME_SCALE = scale
    if not self:isEnableFrame() then return end

    for k, frame in pairs(NIORO_VARS.COMPACT_FRAME) do
        frame:SetScale(NIORO_DB.SETTINGS.FRAME_SCALE)
    end
end

function Actions:setFontStatusScale(scale)
    NIORO_DB.SETTINGS.FONT_STATUS_SCALE = scale
    self:updateFramePart(CompactUnitFrame_UpdateStatusText)
end

function Actions:setFontNameScale(scale)
    NIORO_DB.SETTINGS.FONT_NAME_SCALE = scale
    self:updateFramePart(CompactUnitFrame_UpdateName)
end

function Actions:setShowBuffGlobalToggle(toggle)
    NIORO_DB.SETTINGS.BUFF_SHOW_GLOBAL_TOGGLE = toggle
    if not toggle then self:openConfirm() end
end

function Actions:setShowBuffNum(num)
    NIORO_DB.SETTINGS.BUFF_SHOW_BUFF_MAX = num
end

function Actions:setShowDebuffNum(num)
    NIORO_DB.SETTINGS.BUFF_SHOW_DEBUFF_MAX = num
end

function Actions:setShowDispelDebuffNum(num)
    NIORO_DB.SETTINGS.BUFF_SHOW_DISPEL_DEBUFF_MAX = num
end

