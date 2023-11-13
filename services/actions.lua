local addonName = GetAddOnMetadata(..., 'Title')
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)
local ActionsModule = addon:NewModule('Actions')
local Utils = addon:GetModule('Utils')
local infos = addon:GetModule('Constants'):GetInfos()
local Actions = {}

setmetatable(ActionsModule, {
  __index = function(self, key)
    if Actions[key] then
      if type(key) == 'string'
        and not string.find(key, 'init')
        and InCombatLockdown() then
        Actions:log(ERR_NOT_IN_COMBAT)
        return function()
        end
      end
      return Actions[key]
    end
  end
})

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
  SendSystemMessage(prefix .. text)
end

function Actions:initSlash()
  SLASH_NIORO1 = "/nioro"
  SLASH_NIORO2 = "/NIORO"
  SLASH_NIORO3 = "/nio"
  SlashCmdList['NIORO'] = function(param)
    local Settings = addon:GetModule('Settings', true)
    return Settings and Settings:Open()
  end
end

function Actions:isEnableFrame()
  local pass = Utils:tableLength(NIORO_VARS.COMPACT_FRAME) ~= 0
  -- if not pass then self:log(L.NOT_FOUND_RAID_FRAME) end
  return pass
end

function Actions:isExistsFrame(frame)
  if not frame or not frame.unit then
    return false
  end
  if not frame:IsShown() then
    return false
  end
  if UnitExists(frame.unit) then
    return true
  end
  if UnitExists(frame.displayedUnit) then
    return true
  end
  return false
end

function Actions:updateFramePart(fn)
  if not self:isEnableFrame() then
    return
  end
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

function Actions:updateCompactPartyFrameScale()
  if not NIORO_DB then
    return
  end
  CompactPartyFrame:SetScale(NIORO_DB.SETTINGS.PARTY_FRAME_SCALE)
end

function Actions:updateCompactRaidFrameScale()
  if not NIORO_DB then
    return
  end
  CompactRaidFrameContainer:SetScale(NIORO_DB.SETTINGS.FRAME_SCALE)
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
  self:updateFramePart(CompactUnitFrame_UpdateAuras)
end

function Actions:setDebuffScale(scale)
  NIORO_DB.SETTINGS.DEBUFF_SCALE = scale
  self:updateFramePart(CompactUnitFrame_UpdateAuras)
end

function Actions:setPartyFrameScale(scale)
  NIORO_DB.SETTINGS.PARTY_FRAME_SCALE = scale
  self:updateCompactPartyFrameScale()
end

function Actions:setRaidFrameScale(scale)
  NIORO_DB.SETTINGS.FRAME_SCALE = scale
  self:updateCompactRaidFrameScale()
end

function Actions:setFontStatusScale(scale)
  NIORO_DB.SETTINGS.FONT_STATUS_SCALE = scale
  self:updateFramePart(CompactUnitFrame_UpdateStatusText)
end

function Actions:setFontNameScale(scale)
  NIORO_DB.SETTINGS.FONT_NAME_SCALE = scale
  self:updateFramePart(CompactUnitFrame_UpdateAll)
end

