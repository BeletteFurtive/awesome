local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

batteryimage = wibox.widget.imagebox()

batterywidget = wibox.widget.textbox()
batterywidget:set_align("right")

function update_battery(widget)
   local capacity = io.popen("cat /sys/class/power_supply/BAT0/capacity")
   local charge = io.popen("cat /sys/class/power_supply/BAT0/status")
   
   capacitystatus = capacity:read("*all")
   
   capacity:close()
   
   local capacitystring = string.match(capacitystatus, "%d?%d?%d")
   capacitystring = string.format("% 3d", capacitystring)

   capacitynumber = tonumber(capacitystring)   

   
   if capacitynumber == 20 then
      naughty.notify({ title = "Batterie faible.",
                       text = "Branchez la batterie au plus vite." })
   end
   
   batteryimage:set_image(awful.util.getdir("config") .. "/images/battery_light.png")
   widget:set_markup(capacitystring)   
   
end

update_battery(batterywidget)

mytimer = timer({timeout = 0.2})
mytimer:connect_signal("timeout", function() update_battery(batterywidget) end)
mytimer:start()
