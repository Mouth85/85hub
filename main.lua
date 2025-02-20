local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "85 Hub 👽",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "85 Hub 👽",
   LoadingSubtitle = "by Mouth85",
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Bud Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "WyKgyaykAq", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "85 Hub 👽",
      Subtitle = "Key System",
      Note = "Join discord server for key .gg/WyKgyaykAq", -- Use this to tell the user how to get a key
      FileName = "85Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey =  true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/RAyVats1"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local WBTab = Window:CreateTab("Westbridge", nil) -- Title, Image
local LymeTab = Window:CreateTab("Lyme Regis", nil) -- Title, Image
local OtherTab = Window:CreateTab("Other", nil) -- Title, Image

local Button = OtherTab:CreateButton({
   Name = "Open DEX",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end,
})

local Button = OtherTab:CreateButton({
   Name = "Open Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

local Button = WBTab:CreateButton({
   Name = "Unlock All Cars (CLIENT)",
   Callback = function()
      for _, car in pairs(game.Workspace.Vehicles:GetChildren()) do 
         local lock = car:FindFirstChild("Lock")
         if lock then 
            lock.Value = false
            Rayfield:Notify({
               Title = "Vehicle Unlocked",
               Content = "Unlocked: ".. car.Name,
               Duration = 6.5,
               Image = nil,
            })
         end
      end
   end,
})

local Button = WBTab:CreateButton({
   Name = "Unlock Closest Car (CLIENT)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local closestCar, closestDistance = nil, math.huge
      for _, car in pairs(game.Workspace.Vehicles:GetChildren()) do 
         local carPosition = car.PrimaryPart and car.PrimaryPart.Position
         if carPosition then
            local distance = (carPosition - player.Character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
               closestDistance = distance
               closestCar = car
            end
         end
      end
      if closestCar then
         local lock = closestCar:FindFirstChild("Lock")
         if lock then 
            lock.Value = false
            Rayfield:Notify({
               Title = "Vehicle Unlocked",
               Content = "Unlocked: ".. closestCar.Name,
               Duration = 6.5,
               Image = nil,
            })
         end
      end
   end,
})

local Button = WBTab:CreateButton({
   Name = "Spam Radio Sounds",
   Callback = function()
        while wait(0.01) do 
            game.ReplicatedStorage.Events.MakeRadioSound:FireServer()
        end
   end,
})

local Button = LymeTab:CreateButton({
   Name = "Crash Server",
   Callback = function()
        for _, i in pairs(game.Workspace:GetChildren()) do 
                game.ReplicatedStorage.FlareEvent:FireServer(100, i)
        end
   end,
})

local ToolInput = WBTab:CreateInput({
   Name = "Tool Giver (SERVER)",
   CurrentValue = "",
   PlaceholderText = "Enter tool name",
   RemoveTextAfterFocusLost = false,
   Flag = "ToolInput",
   Callback = function(ToolName)
       local remote = game.Workspace:FindFirstChild("GiveTool", true)
       local player = game.Players.LocalPlayer
       local category = "Tools"
       local flag = true

       if remote and ToolName ~= "" then
           remote:FireServer(ToolName, category, flag, player)
       end
   end,
})

local Dropdown = WBTab:CreateDropdown({
    Name = "Unlock Team Spawner",
    Options = (function()
        local teams = {}
        for _, team in pairs(game:GetService("Teams"):GetChildren()) do
            table.insert(teams, team.Name)
        end
        return teams
    end)(),
    CurrentOption = {"None"},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(SelectedOption)
        local selectedTeam = game:GetService("Teams"):FindFirstChild(SelectedOption[1])
        if selectedTeam then
            game:GetService("Players").LocalPlayer.Team = selectedTeam
        end
    end,
})
