require('klib')
local a, n = {}, arg[1] or 30
for l in io.lines() do
	local t = l:split()
	a[#a+1] = {tonumber(t[1]), tonumber(t[2])}
end
table.sort(a, function(a,b) return a[1] < b[1] or (a[1]==b[1] and a[2]<b[2]) end)

local rest, e = #a, 0
for i = n, 1, -1 do
	local x, z = {}, math.floor(rest / i);
	local y = a[e+z][1]
	while e + z <= #a and a[e+z][1] == y do
		z = z + 1
	end
	z = z - 1
	e = e + z
	for k = 1, e do
		x[k] = {a[k][1], a[k][2]}
	end
	print(x[e][1], math.pearson(x), math.spearman(x))
	rest = rest - z
end
