local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
local AceConfig, AceConfigDialog, AceGUI  = LibStub('AceConfig-3.0'), LibStub('AceConfigDialog-3.0'), LibStub('AceGUI-3.0')
local Settings = addon:NewModule('Settings')
local Menus = addon:GetModule('SettingsMenus')
local Actions = addon:GetModule('Actions')
local Utils = addon:GetModule('Utils')
local options = {
    type = 'group',
    args = {},
}

for k, v in pairs(Menus:getMenus()) do
    options.args[k] = v
end

function Settings:OnInitialize()
    local AceFrame = AceGUI:Create('Frame')
    AceFrame:Hide()
    AceFrame:SetCallback('OnClose', function (w) AceGUI:Release(w) end)
    AceConfig:RegisterOptionsTable('Nioro', options)
    AceFrame:SetTitle('Nioro')
    AceFrame:SetLayout('Flow')
    AceConfigDialog:AddToBlizOptions('Nioro', 'Nioro')
    AceConfigDialog:SetDefaultSize('Nioro', 600, 500)
end

function Settings:Open()
    AceConfigDialog:Open('Nioro', AceFrame)
end
