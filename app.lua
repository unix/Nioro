local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')
local infos = addon:GetModule('Constants'):GetInfos()

function addon:OnInitialize()
    local playerFrame = nil
    local f = CreateFrame('Frame')
    f:RegisterEvent('GROUP_ROSTER_UPDATE')
    -- clear all raid frames when player leave a team
    f:SetScript('OnEvent', function (s, e, a, b)
        if IsInRaid() then return end
        if IsInGroup() then return end
        NIORO_VARS.COMPACT_FRAME = {}
        if not playerFrame then return end
        NIORO_VARS.COMPACT_FRAME['player'] = playerFrame
    end)

    hooksecurefunc('CompactUnitFrame_SetUnit', function (f, unit)
        if not unit or not f then return end
        if not Utils:isRaidFrame(f) then return end
        
        NIORO_VARS.COMPACT_FRAME[unit] = f
        if unit == 'player' then playerFrame = f end

        if not NIORO_DB then return end
        if NIORO_DB.SETTINGS.USE_FLAT_TEXTURE then
            f.healthBar:SetStatusBarTexture(infos.HEALTH_BAR_TEXTURE, 'BORDER')
        end
        if NIORO_DB.SETTINGS.FRAME_SCALE ~= 1 then
            f:SetScale(NIORO_DB.SETTINGS.FRAME_SCALE)
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

end

function addon:OnEnable()
    Actions:updateFrameOptions()
end
