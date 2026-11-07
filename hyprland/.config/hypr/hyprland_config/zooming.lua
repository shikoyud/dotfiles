local MAX_ZOOM = 30
local MIN_ZOOM = 1

local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    else
        current = MIN_ZOOM
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mainMod .. " + ALT + mouse:274", zoom)
hl.bind(mainMod .. " + ALT + mouse_up", function()
    zoom(1)
end)
hl.bind(mainMod .. " + ALT + mouse_down", function()
    zoom(-1)
end)
