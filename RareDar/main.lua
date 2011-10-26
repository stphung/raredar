--- Builds a table which maps a list of values to boolean true for hash-based search.
--
-- @param list The list of elements
local function Set(list)
   local set = {}
   for _, e in ipairs(list) do
      set[e] = true
   end
   return set
end

-- A table of all the rares
all_rares = Set{
   "Raging Warmachine",
   "Defiant Assassin",
   "Gizzit",
   "Augustor",
   "Tormented Wisp",
   "Crepit Pokeit",
   "Sea Scuttler",
   "Gogrol",
   "Azagamara",
   "Vengeful Spirit",
   "Brod",
   "Marlrog",
   "Mok",
   "Pandora",
   "Pentheus",
   "Silverwood Werewolf",
   "Bahezerk",
   "Boneseeker",
   "Gnarvul",
   "Gorehorn the Mighty",
   "Gormungun",
   "Lothuu the Sad",
   "Nela Valcuthren",
   "Questing Overseer",
   "Rendfang",
   "Sentient Cruor",
   "Stone Rend",
   "Stridal",
   "Xoxtillus",
   "XT-300",
   "Browncap Cutter",
   "Dozer",
   "Gnarl Nighthunter",
   "Lunar Shadestalker",
   "Millrush Moonstalker",
   "Scald",
   "Scarbite",
   "Stalker of Tears",
   "Stalker of the Grove",
   "Xaksha",
   "Zatzak Browncap",
   "Nightfang",
   "Rockjaw",
   "Korgek the Breaker",
   "Ghorgull",
   "Quogor",
   "Gurock",
   "Lashtail",
   "Rotwhip",
   "Shadow Harvester",
   "Bloodwhisker",
   "Gravelfist",
   "Nuhtu",
   "Granite Crawler",
   "Ironfang",
   "Blister",
   "Rivetskull",
   "Errant Wrecker",
   "Razorback Terror",
   "Barbwing",
   "Venomspitter",
   "Corpsegrinder",
   "Scarbeak",
   "Ahasa",
   "Vasyu",
   "Blackclaw",
   "Vilehide",
   "Raging Summoner",
   "Razorfang",
   "Deranged Pyromancer",
   "Fezziled the Curious",
   "Nytami",
   "Lugog the Destroyer",
   "Arumal",
   "Aelfwar Emissary",
   "Freddik the Broken",
   "Enraged Scarab",
   "Mordant Widow",
   "Kragnix the Annihilator",
   "Forgotten Sacrifice",
   "Glogg the Ravenous",
   "Hurknok",
   "Koglok",
   "Bone-Fed Ripper",
   "Jhomm The Cruel",
   "Netherworld Wanderer",
   "Emissary Kavenik",
   "Frosthide",
   "Arctic Peakstalker",
   "Mad Hogger",
   "Dagda Skullthumper",
   "Razormane",
   "Swirling Tempest",
   "Blackblood Drake",
   "Frostpaw Mauler",
   "The Predator",
   "Mangled Exile",
   "Grand Councilman Al'hazeed",
   "Lord Scaldwater",
   "Blood Bough",
   "Taziel Kanur",
   "Thagrux the Unclean",
   "Khromas the Eternal",
   "Spineclaw",
   "Experimental War Golem",
   "The Endless Broodmother",
   "Jom Turner",
   "Azumel the Screecher",
   "Coastal Stalker"
}

--- Determines whether a list of units contains a rare.
--
-- @param units The list of units
-- @param rares The list of rare units
local function get_rares(units, all_rares)
   rares = {}
   for k,v in pairs(units) do
--      print(k, type(k), v, type(v))
      if k ~= nil and type(k) == "string" then
         unit_name = Inspect.Unit.Detail(k)["name"]
         if all_rares[unit_name] then
--            print("Rare Found! => " .. unit_name)
            table.insert(rares, unit_name)
         end
      end
   end
   return rares
end

local function print_table(table)
   for k,v in pairs(table) do
      if type(k) == "table" then
         print_table(k)
      else
         print(k, "=>", v)
      end
   end
end

local function print_units(units)
   get_rares(units, all_rares)
end

-- Global variables, sigh :(
local time = Inspect.Time.Real()
local context = UI.CreateContext("raredar_context")
local bar = UI.CreateFrame("Frame", "Bar", context)
bar.solid = UI.CreateFrame("Frame", "Solid", bar)
bar.text = UI.CreateFrame("Text", "Text", bar)

local function display_notification(bar, text)
   -- Set an initial vertical pin to make some of our calculations work properly
   bar:SetPoint("TOP", UIParent, "TOP")
   bar:SetPoint("BOTTOM", bar.text, "BOTTOM")  -- The bar is set to always be as high as the text is.

   -- Text
   bar.text:SetFontSize(25)
   bar.text:SetText(text)
   bar.text:SetHeight(bar.text:GetFullHeight())
   bar.text:SetWidth(bar.text:GetFullWidth())
   bar.text:SetPoint("TOPLEFT", bar, "TOPLEFT")

   -- Solid background
   bar.solid:SetLayer(-1)  -- Put it behind every other element.
   bar.solid:SetWidth(bar.text:GetFullWidth())
   bar.solid:SetPoint("TOPLEFT", bar, "TOPLEFT")
   bar.solid:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT")
   bar.solid:SetBackgroundColor(0.5, 0.3, 0.9, 0.4)

   -- Set to the center of the screen
   bar:SetPoint("TOPCENTER", UIParent, "TOPCENTER", -bar.text:GetFullWidth()/2, 20)

   bar:SetVisible(true)
end

local function hide_notification(bar)
   bar:SetVisible(false)
end

local function rare_notification(units)
   rares = get_rares(units, all_rares)

   if table.getn(rares) > 0 then
--      print_table(rares)
      time = Inspect.Time.Real()
      msg = rares[1] .. " found!"
      print("Ping! " .. msg)
      display_notification(bar, msg)
   end
end

local function fade_notification()
   if Inspect.Time.Real() - time > 10 then
      hide_notification(bar)
   end
end

-- Display a notification
table.insert(Event.Unit.Available, {rare_notification, "RareDar", "rare_notification"})

-- Try to fade out the notification periodically
table.insert(Event.System.Update.Begin, {fade_notification, "RareDar", "fade_notification"})
