strs = "x, y, w, h"

for a in string.gmatch(strs, "%w+") do
    print(string.format("self.%s = %s or 0", a, a))
end