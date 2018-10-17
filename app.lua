local addonName = GetAddOnMetadata(..., 'Title')
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local infos = addon:GetModule('Constants'):GetInfos()
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')

-- local ef = CreateFrame('Frame')
-- ef:RegisterEvent('ADDON_ACTION_BLOCKED')
-- ef:RegisterEvent("ADDON_ACTION_FORBIDDEN")
-- ef:SetScript('OnEvent', function (s, e, name, desc) 
--     local type = (e == 'ADDON_ACTION_BLOCKED' and 'BLOCKED') or 'FORBIDDEN'
--     print('Error '..type.. ':', name, desc)
-- end)

function addon:OnInitialize()
    local setTexture = function (frame)
        if not NIORO_DB then return end
        if NIORO_DB.SETTINGS.USE_FLAT_TEXTURE then
            frame.healthBar:SetStatusBarTexture(.75, .75, .75)
        end

        if NIORO_DB.SETTINGS.BUFF_SHOW_GLOBAL_TOGGLE then
            frame.maxBuffs = NIORO_DB.SETTINGS.BUFF_SHOW_BUFF_MAX
            frame.maxDebuffs = NIORO_DB.SETTINGS.BUFF_SHOW_DEBUFF_MAX
            frame.maxDispelDebuffs = NIORO_DB.SETTINGS.BUFF_SHOW_DISPEL_DEBUFF_MAX
        end
    end

    hooksecurefunc('DefaultCompactUnitFrameSetup', function (f)
        setTexture(f)
    end)

    hooksecurefunc('CompactUnitFrame_SetUnit', function (f, unit)
        if not unit then return end
        if not Utils:isRaidFrame(f) then return end
        if not f:IsShown() then return end

        setTexture(f)
        NIORO_VARS.COMPACT_FRAME[unit] = f
    end)

    hooksecurefunc('CompactUnitFrame_UpdateBuffs', function (f)
        if not f.buffFrames then return end
        for i = 1, #f.buffFrames do
            local buff = f.buffFrames[i]
            if buff and buff.SetScale and buff:IsShown() then 
                if NIORO_DB.SETTINGS.USE_FLAT_ICON then
                    buff.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
                end
                if NIORO_DB.SETTINGS.HIDDEN_BUFF_TOOLTIP then
                    buff:SetScript('OnEnter', function() end)
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
                if NIORO_DB.SETTINGS.HIDDEN_DEBUFF_TOOLTIP then
                    debuff:SetScript('OnEnter', function() end)
                end
                debuff:SetScale(NIORO_DB.SETTINGS.DEBUFF_SCALE) 
            end
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateName', function (f)
        if not Utils:isRaidFrame(f) then return end
        if not f.name or not f.name:IsShown() then return end

        if not NIORO_DB.SETTINGS.DISPLAY_NAME or not ShouldShowName(f) then 
            return f.name:SetText(' ')
        end

        local name = (not NIORO_DB.SETTINGS.USE_SHORT_NAME and GetUnitName(f.unit, true)) or UnitFullName(f.unit)
		if ( C_Commentator.IsSpectating() and name ) then
			local overrideName = C_Commentator.GetPlayerOverrideName(name)
			if overrideName then name = overrideName end
		end

        f.name:SetText(name)

        if NIORO_DB.SETTINGS.FONT_NAME_SCALE then
            local fontName, fontSize, fontFlags = f.name:GetFont()
            f.name.nioro_size = f.name.nioro_size or fontSize
            f.name:SetFont(fontName, f.name.nioro_size * NIORO_DB.SETTINGS.FONT_NAME_SCALE, fontFlags)
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateStatusText', function (f)
        if not Utils:isRaidFrame(f) then return end
        if not f.statusText or not f.statusText:IsShown() then return end

        if NIORO_DB.SETTINGS.FONT_STATUS_SCALE  then
            local fontName, _, fontFlags = f.statusText:GetFont()
            local options = DefaultCompactUnitFrameSetupOptions
            local comScale = min(options.height / infos.NATIVE_UNIT_FRAME_HEIGHT, options.width / infos.NATIVE_UNIT_FRAME_WIDTH)
            local nextFontSize = infos.NATIVE_FONT_SIZE * comScale * NIORO_DB.SETTINGS.FONT_STATUS_SCALE
            f.statusText:SetFont(fontName, nextFontSize, fontFlags)
        end

        -- in PERC mode
        if (f.optionTable.healthText == 'perc') and (UnitHealthMax(f.displayedUnit) > 0) then 
            if NIORO_DB.SETTINGS.USE_SHORT_PERC then
                local text = f.statusText:GetText()
                f.statusText:SetText(string.gsub(text, '%%', ''))
            end
        end
    end)

    hooksecurefunc('CompactUnitFrame_UpdateRoleIcon', function (f)
        if not f or not f.roleIcon then return end
        local role = UnitGroupRolesAssigned(f.unit)
        f.roleIcon.shouldShowRole = (f.roleIcon.shouldShowRole == nil and f.roleIcon:IsShown()) or f.roleIcon.shouldShowRole
        if NIORO_DB.SETTINGS.DISPLAY_ROLE_ICON and f.roleIcon.shouldShowRole then
            f.roleIcon:Show()
            f.roleIcon:SetScale(1)
        else
            f.roleIcon:Hide()
            f.roleIcon:SetScale(0.01)
        end
    end)

    hooksecurefunc('CompactRaidGroup_InitializeForGroup', function (f)
        if f and NIORO_DB.SETTINGS.HIDDEN_GROUP_NAME then
            f.title:Hide()
        end
    end)

    hooksecurefunc('CompactPartyFrame_Generate', function ()
        if CompactPartyFrame and CompactPartyFrame.title and NIORO_DB.SETTINGS.HIDDEN_GROUP_NAME then
            CompactPartyFrame.title:Hide()
        end
    end)
    
end

function addon:OnEnable()
    Actions:updateCompactRaidFrameScale()
end
