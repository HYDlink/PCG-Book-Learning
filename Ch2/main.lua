require 'util'
Class = require "class"
local Rect = require "Rect"
local Node = require "BSP"


local fullRect
local bsp
function love.load()
    local sw, sh = love.window.getMode()
    fullRect = Rect(0, 0, sw, sh)
    
    function createCell(rect, node)
        -- 随机选择一个 bound

        local wp = math.remap(math.random(), 0, 1, 0.7, 1)
        local hp = math.remap(math.random(), 0, 1, 0.7, 1)
        local w, h = wp * rect.w, hp * rect.h
        local offset = { x = math.random(0, rect.w - w), y = math.random(0, rect.h - h) }
        node.cell = Rect(offset.x + rect.x, offset.y + rect.y, w, h)
    end

    bsp = Node.createRandomBSP(fullRect, 16, 64, 64, createCell)
end

function love.draw()
    bsp:draw(16, 16)
end
