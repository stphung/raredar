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
         unit_name = Inspect.Unit.Detail(k)["name"]
         if all_rares[unit_name] then
            table.insert(rares, unit_name)
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
