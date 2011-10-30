--------------------------------------------------------------------------------
-- Mapping of event handlers to event types.
--------------------------------------------------------------------------------

-- Notification display
table.insert(Event.Unit.Available, {show_notification_from_units, "RareDar", "Display Notification"})

-- Notification fading
table.insert(Event.System.Update.Begin, {fade_notification, "RareDar", "Fade Notification"})

-- Initialization
function init(addon)
   if addon == "RareDar" then
      print("loaded!  We'll do our best to let you know when we find a rare mob!")
   end
end

table.insert(Event.Addon.Load.End, {init, "RareDar", "Initialization"})
