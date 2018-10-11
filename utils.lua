local addon = LibStub('AceAddon-3.0'):GetAddon('Nioro')
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


