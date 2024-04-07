if game.CreatorId == 11126716 then
	if game.PlaceId == 15441481660 or game.PlaceId == 15723206381 or game.PlaceId == 15600701539 or game.PlaceId == 15498227813 then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/games/reahlistic.lua"))()
	else
		loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/system/premiumsys/hoopslife.lua"))()
    		loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/games/hoopslife.lua"))()
	end
elseif game.CreatorId == 1109656080 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/games/sl2.lua"))()
elseif game.CreatorId == 2894777 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/games/uf.lua"))()
elseif game.CreatorId == 5218591 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/games/rh2.lua"))()
elseif game.CreatorId == 16811615 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/games/hoopnation.lua"))()
end

if queue_on_teleport then
	queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/xurel7/solarhub/main/key-system/loader.lua"))()')
end
