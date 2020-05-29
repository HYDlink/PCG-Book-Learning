---@class Rect : Class
---@field public x number
---@field public y number
---@field public w number
---@field public h number
local Rect =
    Class {
    x,
    y,
    w,
    h
}

function Rect:init(x, y, w, h)
    self.x = x or 0
    self.y = y or 0
    self.w = w or 0
    self.h = h or 0
end

---@param rhs Rect
---@return boolean
function Rect.intersect(lhs, rhs)
    local x1, x2, x3, x4 = lhs.x, rhs.x, lhs.x + lhs.w, rhs.x + rhs.w
    local y1, y2, y3, y4 = lhs.y, rhs.y, lhs.y + lhs.h, rhs.y + rhs.h
    if (x2 < x3 and x1 < x4) and (y2 < y3 and y1 < y4) then
        return true
    else
        return false
    end
end

function Rect:__tostring()
    return string.format("(%d, %d, %d, %d)", self.x, self.y, self.w, self.h)
end

return Rect
