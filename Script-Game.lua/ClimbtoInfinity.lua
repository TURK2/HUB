local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Window = Rayfield:CreateWindow({
   Name = "TURKXSRCIPT Hub",
   LoadingTitle = "TURKXSRCIPT Hub",
   LoadingSubtitle = "YT: TURKXSRCIPT",
   ConfigurationSaving = {
      Enabled = false
   }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- เลือกโลก
local SelectedZone = "1"

MainTab:CreateDropdown({
   Name = "Select World",
   Options = {"1","2","3","4","5","6","7","8","9","10","11","12"},
   CurrentOption = {"1"},
   Callback = function(Option)
      SelectedZone = Option[1]
   end,
})

-- Auto Win
local AutoWin = false

MainTab:CreateToggle({
   Name = "Auto Win",
   CurrentValue = false,
   Callback = function(Value)
      AutoWin = Value
      
      if AutoWin then
         local player = Players.LocalPlayer
         local char = player.Character or player.CharacterAdded:Wait()

         if char and char:FindFirstChild("HumanoidRootPart") then

            -- วาร์ปไปพื้นก่อน
            local floor = workspace.Zones[SelectedZone].Miscallaneuos.Floors.Model
            char.HumanoidRootPart.CFrame = floor:GetPivot()

            task.wait(2)

         end
      end

      while AutoWin do
         local player = Players.LocalPlayer
         local char = player.Character
         
         if char and char:FindFirstChild("HumanoidRootPart") then
            local win = workspace.Zones[SelectedZone].Gameplay.WinPlatforms["8"].WinButton
            char.HumanoidRootPart.CFrame = win.CFrame + Vector3.new(0,3,0)
         end
         
         task.wait(0.5)
      end
   end,
})

-- Auto Rebirth
local AutoRebirth = false

MainTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      AutoRebirth = Value
      
      while AutoRebirth do

         local args = {
            "Rebirths",
            "MaxRebirth"
         }

         ReplicatedStorage.Events.InvokeServerAction:InvokeServer(unpack(args))

         task.wait(1)
      end
   end,
})

-- About
local AboutTab = Window:CreateTab("About", 4483362458)

AboutTab:CreateParagraph({
   Title = "Credits",
   Content = "YouTube: TURKXSRCIPT"
})

AboutTab:CreateButton({
   Name = "Copy Discord",
   Callback = function()
      setclipboard("https://discord.gg/yourlink")
      Rayfield:Notify({
         Title = "Copied!",
         Content = "Discord copied",
         Duration = 4
      })
   end,
})