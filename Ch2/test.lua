Class = require 'class'
local Rect = require 'Rect'
local Node = require 'BSP'

fullRect = Rect(0, 0, 640, 480)
    bsp = Node.createRandomBSP(fullRect, 16, 64, 64, createCell)