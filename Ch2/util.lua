unpack = table.unpack or unpack

function math.remap(src, a, b, x, y)
    return ((src - a) * (y - x) / (b - a)) + x
end 