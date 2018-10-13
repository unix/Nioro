local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local infos = addon:GetModule('Constants'):GetInfos()
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')
local playerFrame = nil
local tryReloadOptions = false

function addon:OnInitialize()
    -- set global options when db loaded,
    -- else, reload each frame with manually.
    if NIORO_DB then
        Actions:setGlobalOptions()
    else
        tryReloadOptions = true
    end

    local f = CreateFrame('Frame')
    f:RegisterEvent('GROUP_ROSTER_UPDATE')
    -- clear all raid frames when player leave a team
    f:SetScript('OnEvent', function (s, e)
        if e ~= 'GROUP_ROSTER_UPDATE' then return end
        if IsInRaid() then return end
        if IsInGroup() then return end

        NIORO_VARS.COMPACT_FRAME = {}
        if not playerFrame then return end
        NIORO_VARS.COMPACT_FRAME['player'] = playerFrame
    end)
    local setTexture = function (frame)
        if not NIORO_DB then return end
        if NIORO_DB.SETTINGS.USE_FLAT_TEXTURE then
            frame.healthBar:SetStatusBarTexture(infos.HEALTH_BAR_TEXTURE, 'BORDER')
        end
        if NIORO_DB.SETTINGS.FRAME_SCALE ~= 1 then
            frame:SetScale(NIORO_DB.SETTINGS.FRAME_SCALE)
        end
    end

    hooksecurefunc('DefaultCompactUnitFrameSetup', function (f)
        setTexture(f)
    end)

    hooksecurefunc('CompactUnitFrame_SetUnit', function (f, unit)
        if not unit or not f then return end
        if not Utils:isRaidFrame(f) then return end

        setTexture(f)
        NIORO_VARS.COMPACT_FRAME[unit] = f
        if unit == 'player' then playerFrame = f end

        if tryReloadOptions then
            Actions:updateFrameOptions()
            tryReloadOptions = false
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateBuffs', function (f)
        if not f.buffFrames then return end
        for i = 1, #f.buffFrames do
            local buff = f.buffFrames[i]
            if buff and buff.SetScale and buff:IsShown() then 
                if NIORO_DB.SETTINGS.USE_FLAT_ICON then
                    buff.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
                end
                buff:SetScale(NIORO_DB.SETTINGS.BUFF_SCALE)
            end
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateDebuffs', function (f)
        if not f.debuffFrames then return end
        for i = 1, #f.debuffFrames do
            local debuff = f.debuffFrames[i]
            if debuff and debuff.SetScale and debuff:IsShown() then 
                if NIORO_DB.SETTINGS.USE_FLAT_ICON then
                    debuff.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
                end
                debuff:SetScale(NIORO_DB.SETTINGS.DEBUFF_SCALE) 
            end
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateName', function (f)
        if not f.name or not f.name:IsShown() then return end
        if not Utils:isRaidFrame(f) then return end

        if NIORO_DB.SETTINGS.USE_SHORT_NAME then
            f.name:SetText(UnitFullName(f.unit))
        end

        if NIORO_DB.SETTINGS.FONT_NAME_SCALE then
            local fontName, fontSize, fontFlags = f.name:GetFont()
            f.name.nioro_size = f.name.nioro_size or fontSize
            f.name:SetFont(fontName, f.name.nioro_size * NIORO_DB.SETTINGS.FONT_NAME_SCALE, fontFlags)
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateStatusText', function (f)
        if not f.statusText or not f.statusText:IsShown() then return end
        if not Utils:isRaidFrame(f) then return end

        if NIORO_DB.SETTINGS.FONT_STATUS_SCALE  then
            local fontName, _, fontFlags = f.statusText:GetFont()
            local options = DefaultCompactUnitFrameSetupOptions
            local comScale = min(options.height / infos.NATIVE_UNIT_FRAME_HEIGHT, options.width / infos.NATIVE_UNIT_FRAME_WIDTH)
            local nextFontSize = infos.NATIVE_FONT_SIZE * comScale * NIORO_DB.SETTINGS.FONT_STATUS_SCALE
            f.statusText:SetFont(fontName, nextFontSize, fontFlags)
        end

        if NIORO_DB.SETTINGS.USE_SHORT_PERC then
            local text = f.statusText:GetText()
            local isPrec = string.find(text, '%%')
            if not isPrec then return end
            f.statusText:SetText(string.gsub(text, '%%', ''))
        end
    end)

    hooksecurefunc('CompactUnitFrame_SetMaxBuffs', function (f)
        if not f then return end
        if not Utils:isRaidFrame(f) then return end
        if NIORO_DB.SETTINGS.BUFF_SHOW_BUFF_MAX then
            f.maxBuffs = NIORO_DB.SETTINGS.BUFF_SHOW_BUFF_MAX
        end
    end)

    hooksecurefunc('CompactUnitFrame_SetMaxDebuffs', function (f)
        if not f then return end
        if not Utils:isRaidFrame(f) then return end
        if NIORO_DB.SETTINGS.BUFF_SHOW_DEBUFF_MAX then
            f.maxDebuffs = NIORO_DB.SETTINGS.BUFF_SHOW_DEBUFF_MAX
        end
    end)

    hooksecurefunc('CompactUnitFrame_SetMaxDispelDebuffs', function (f)
        if not f then return end
        if not Utils:isRaidFrame(f) then return end
        if NIORO_DB.SETTINGS.BUFF_SHOW_DISPEL_DEBUFF_MAX then
            f.maxDispelDebuffs = NIORO_DB.SETTINGS.BUFF_SHOW_DISPEL_DEBUFF_MAX
        end
    end)

end

function addon:OnEnable()
    -- fix init frame in en-US
    -- the raid frame may be delayed loading when player first login in en-US server
    if not tryReloadOptions then return end
    Actions:updateFrameOptions()
    tryReloadOptions = false
end
