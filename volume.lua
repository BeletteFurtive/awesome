local wibox = require("wibox")
local awful = require("awful")
local naughty   = require("naughty")


volumeimage = wibox.widget.imagebox()

volumewidget = wibox.widget.textbox()
volumewidget:set_align("right")
 
function update_volume(widget, notification)
   naughty.destroy(notification)
   local volume = io.popen("amixer sget Master")
   local volumestatus = volume:read("*all")
   local volumenumber
   local indic = ""

   volume:close()
 
   local volumestring = string.match(volumestatus, "(%d?%d?%d)%%")
   volumestring = string.format("% 3d", volumestring)
 
   volumestatus = string.match(volumestatus, "%[(o[^%]]*)%]")


   --create a string for the notification
   volumenumber = tonumber(volumestring)   
   for v=0, volumenumber, 10
   do
      indic = indic .. "▫"
   end
   

   if string.find(volumestatus, "on", 1, true) then

      volumeimage:set_image(awful.util.getdir("config") .. "/images/volume_active.png")

   else
      volumeimage:set_image(awful.util.getdir("config") .. "/images/volume_mute.png")
      
       
   end
   widget:set_markup(volumestring)
   return indic
      
end

update_volume(volumewidget)
 
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volumewidget) end)
mytimer:start()
