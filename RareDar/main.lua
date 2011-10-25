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
rares = Set{
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
   "Azumel the Screecher"
}

--- Determines whether a list of units contains a rare.
--
-- @param units The list of units
-- @param rares The list of rare units
local function contains_rare(units, rares)
   res = false
   for k,v in ipairs(units) do
      res = res or rares[v]
   end
   return res
end

--- Test function for testing the event behavior.
--
-- @param units The list of units
local function printUnits(units)
   for k,v in pairs(units) do
      print(k .. " => " .. v)
   end
end

-- The rare entered!
table.insert(Event.Unit.Add, printUnits)

-- The rare left!
table.insert(Event.Unit.Remove, printUnits)
