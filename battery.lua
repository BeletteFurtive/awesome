local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

batteryimage = wibox.widget.imagebox()

batterywidget = wibox.widget.textbox()
batterywidget:set_align("right")

function update_battery(widget)
   local capacity = io.popen("cat /sys/class/power_supply/BAT0/capacity")
   local charge = io.popen("cat /sys/class/power_supply/BAT0/status")
   local capacitystring
   local capacitystatus
   
   capacitystatus = "  " .. capacity:read()
   chargestatus = charge:read()
   
   capacity:close()
   charge:close()

   
   capacitynumber = tonumber(capacitystatus)   

   
   if chargestatus:match("Discharging") then
   
      if capacitynumber < 10 then

         naughty.notify({ title = "Batterie faible : ",
                          text = "Branchez la batterie au plus vite.",
                          icon=awful.util.getdir("config") .. "/images/battery_low.png",
         })

         
         batteryimage:set_image(awful.util.getdir("config") .. "/images/battery_low.png")
         
      else
         
         batteryimage:set_image(awful.util.getdir("config") .. "/images/battery_light.png")
         
      end

   else
      batteryimage:set_image(awful.util.getdir("config") .. "/images/battery_charging.png")

   end
      
   widget:set_markup(capacitystatus)   
   
end

--update_battery(batterywidget)

--mytimer = timer({timeout = 20})
--mytimer:connect_signal("timeout", function() update_battery(batterywidget) end)
--mytimer:start()

