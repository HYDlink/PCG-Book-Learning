Class = require 'class'
local Rect = require 'Rect'
r1 = Rect(10, 10, 40, 40)
r2 = Rect(30, 20, 40, 40)
print(r1:intersect(r2))