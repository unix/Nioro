local L = LibStub("AceLocale-3.0"):GetLocale('Nioro', false)
local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local Actions = addon:GetModule('Actions')
local infos = addon:GetModule('Constants'):GetInfos()
local CompactUnitFrame

function addon:OnInitialize()

    hooksecurefunc('CompactUnitFrame_SetUnit', function (f, unit)
        if unit == nil then return end
        if not UnitInParty('player') and not IsInRaid() then 
            NIORO_VARS.COMPACT_FRAME = {}
        end
        NIORO_VARS.COMPACT_FRAME[unit] = f
        if NIORO_DB.SETTINGS.USE_FLAT_TEXTURE then
            f.healthBar:SetStatusBarTexture(infos.HEALTH_BAR_TEXTURE, 'BORDER')
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
        if not NIORO_DB.SETTINGS.USE_SHORT_NAME then return end
        if not f.name or not f.name:IsShown() then return end
        f.name:SetText(UnitFullName(f.unit))
    end)

end

function addon:OnEnable()
    Actions:updateFrameOptions()
end
