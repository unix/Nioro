local addonName = GetAddOnMetadata(..., 'Title')
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local Utils = addon:NewModule('Utils')

function Utils:toboolean(t)
    return (t and true) or false
end

function Utils:setState(obj, key, value)
    if not obj then return {} end
    local next = obj
    next[key] = value
    return next
end

function Utils:tableLength(t)
    if not t then return 0 end
    local count = 0
    for _, _ in pairs(t) do 
        count = count + 1
    end
    return count
end

-- when val is nil, don't make any changes, this may be the caller's failure.
-- when return true, caller hook will be skip.
function Utils:isDefaultSetting(key, val)
    if val == nil then return true end
    if NIORO_DB.DEFAULT_SETTINGS[key] == nil then return true end
    return NIORO_DB.DEFAULT_SETTINGS[key] == val
end

function Utils:isRaidFrame(f)
    if not f then return false end
    if f.unit and string.find(f.unit, 'nameplate') then return false end

    local name = f:GetName()
    if not name then return false end
    local isRaidFrame = string.find(name, 'CompactRaidFrame')
    local isPartyFrame = string.find(name, 'CompactPartyFrame')
    local isRaidGroupFrame = string.find(name, 'CompactRaidGroup')
    if not isRaidFrame and not isPartyFrame and not isRaidGroupFrame  then return false end
    return true
end
