local wibox = require("wibox")
local awful = require("awful")
local naughty   = require("naughty")


local toggled = true;
function toggle_touchpad()

   toggled = not(toggled);
   if(toggled) then
      awful.util.spawn("xinput -enable 16")
   else
      awful.util.spawn("xinput -disable 16")
   end
end
