--------------------------------------------------------------------------------
-- A single state variable and functions for controlling notification display.
--------------------------------------------------------------------------------

local bar = nil

--- Displays a notification if a rare is found in a list of units.
--
-- @param list The units "the client can see"
function show_notification_from_units(units)
   local function found_message(unit)
      return unit .. " found!"
   end
   rares = get_rares(units, all_rares)
   if table.getn(rares) > 0 then
      local message = found_message(rares[1])
      print(message)
      show_notification(message)
   end
end

function show_notification(message)
   -- Hide the currently displayed notification.
   if bar ~= nil then
      bar:SetVisible(false)
   end

   -- Display the new notification.
   bar = display_notification(message, horizontal_padding, horizontal_offset, red, green, blue, alpha)
end

--- Fades a notification out.
--
-- Closes on display_time and fade_time defined in config.lua.
--
-- @param display_time The total duration in seconds to display the notification.
-- @param fade_time The time spent to fade out the notification.
--
-- Examples
--
--   fade_notification with display_time = 10.0 and fade_time = 3.0
--   => When the notification is displayed it will be displayed for a total of 10 total seconds beginning fading out after 7 seconds and completely faded out after 10 seconds.
function fade_notification()
   if bar ~= nil then
      dt = Inspect.Time.Real() - bar.time
      if dt > display_time then
         bar:SetVisible(false)
      elseif display_time-dt < fade_time then
         normalized_dt = fade_time - (display_time - dt)
         new_alpha = alpha-((normalized_dt/fade_time)*alpha)
         bar:SetAlpha(new_alpha)
      end
   end
end
