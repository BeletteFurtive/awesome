local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")



bat = wibox.widget.textbox()
bat:set_align("right")

function update(widget)

   local capacity = io.popen("cat /sys/class/power_supply/BAT0/capacity")
   capacitystatus = " " .. capacity:read()
   widget:set_markup(capacitystatus)
   
end




update(bat)


mytimer = timer({timeout = 20})
mytimer:connect_signal("timeout", function() update_(bat) end)
mytimer:start()

