require('klib')
local a, n = {}, arg[1] or 20
for l in io.lines() do
	local t = l:split()
	a[#a+1] = {tonumber(t[1]), tonumber(t[2]), tonumber(t[3])}
end
table.sort(a, function(a,b) return a[1] < b[1] or (a[1]==b[1] and a[2]<b[2]) end)

local rest, b, xx = #a, 1, 0
for i = n, 1, -1 do
	if rest == 0 then break end
	local e = b + math.floor(rest / i) - 1;
	local y = a[e][1]
	while e <= #a and a[e][1] == y do e = e + 1 end
	e = e - 1
	local x, c = 0, 0
	for k = b, e do
		--x = x + (a[k][3]-a[k][2]) * (a[k][3]-a[k][2]) / a[k][2]
		x = x + (a[k][3]-a[k][2]) * (a[k][3]-a[k][2])
		c = c + 1
	end
	print(a[e][1], math.sqrt(x / c))
	rest = rest - (e - b + 1)
	b, xx = e + 1, xx + x
end
--print(xx)
