loadstring(game:HttpGet("https://raw.githubusercontent.com/TURK2/HUB/refs/heads/main/main-hub/GameList.lua"))()
for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
