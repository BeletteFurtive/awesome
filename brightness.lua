local wibox = require("wibox")
local awful = require("awful")
local naughty   = require("naughty")

brightnessimage = wibox.widget.imagebox()

brightnesswidget = wibox.widget.textbox()
brightnesswidget:set_align("right")

function update_brightness(widget, notification)
   naughty.destroy(notification)
   local brightness = io.popen("xbacklight")
   local brightnessstatus = brightness:read("*all")
   local brightnessnumber
   local indic = ""

   brightness:close()
   
   local brightnessstring = string.match(brightnessstatus, "%d?%d?%d")
   brightnessstring = string.format("% 3d", brightnessstring)

   brightnessimage:set_image(awful.util.getdir("config") .. "/images/brightness_light.png")
   widget:set_markup(brightnessstring)

end


update_brightness(brightnesswidget)

mytimer = timer({ timeout = 1 })
mytimer:connect_signal("timeout", function () update_brightness(brightnesswidget) end)
mytimer:start()
