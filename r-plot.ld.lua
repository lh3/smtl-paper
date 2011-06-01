require('klib')
local a, n = {}, arg[1] or 20
for l in io.lines() do
	local t = l:split()
	a[#a+1] = {tonumber(t[1]), tonumber(t[2]), tonumber(t[3])}
end
table.sort(a, function(a,b) return a[1] < b[1] or (a[1]==b[1] and a[2]<b[2]) end)

local rest, b = #a, 1
for i = n, 1, -1 do
	if rest == 0 then break end
	local x, e = {}, b + math.floor(rest / i) - 1;
	local y = a[e][1]
	while e <= #a and a[e][1] == y do e = e + 1 end
	e = e - 1
	local avg = 0
	for k = 1, e do
		x[#x+1] = {a[k][2], a[k][3]}
		avg = avg + a[k][1]
	end
	print(a[e][1], math.spearman(x), #x)
	rest = rest - (e - b + 1)
	b = e + 1
end
