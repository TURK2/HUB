getgenv().Games = {
    [8003084678] = "https://raw.githubusercontent.com/TURK2/HUB/main/Script-Game.lua/oMega%20Obby.lua",
}

local id = game.PlaceId
local url = getgenv().Games[id]

if url then
    print("🟢 กำลังโหลด script จาก: " .. url)
    local success, result = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("🔴 เกิดข้อผิดพลาด: ", result)
    end
else
    warn("🟡 ไม่พบ script สำหรับเกมนี้ (PlaceId: " .. tostring(id) .. ")")
end
