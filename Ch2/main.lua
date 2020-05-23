unpack = table.unpack or unpack

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
        
    end

    bsp = Node.createRandomBSP(fullRect, 16, 64, 64)
end

function love.draw()
    bsp:draw(16, 16)
end
