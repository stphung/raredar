local RareDar, private = ...

--------------------------------------------------------------------------------
-- Utility and debugging related functions.
--------------------------------------------------------------------------------

--- Prints a table
--
-- @param table The table
local function print_table(table)
   for k,v in pairs(table) do
      if type(k) == "table" then
         print_table(k)
      else
         print(k, "=>", v)
      end
   end
end

--- Determines whether a list of units contains a rare.
--
-- @param units The list of units.
-- @param rares The list of rare units.
-- @return a list of rares found in units.
function get_rares(units, all_rares)
   rares = {}
   for k,v in pairs(units) do
      if k ~= nil and type(k) == "string" then
         -- Check that the unit is neither a player nor a pet as
         -- both players and pets can have the same name as rare mobs
         -- TODO: Check API reference for better way (than searching
         -- the secondary name for the word Pet) to check if the unit
         -- is a pet or not.
         local detail = Inspect.Unit.Detail(k)
         secname = detail["nameSecondary"]
         if not detail["player"] and
            (secname == nil or not string.find(secname, " Pet")) then
            unit_name = detail["name"]
            if all_rares[unit_name] then
               table.insert(rares, unit_name)
            end
         end
      end
   end
   return rares
end

--- Function which closes on the all_rares table to be invoked on Event.Unit.Available.
--
-- @param units The list of newly available units that "the client can see".
local function print_units(units)
   get_rares(units, all_rares)
end
