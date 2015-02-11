local wibox = require("wibox")
local awful = require("awful")
local naughty   = require("naughty")


function notify()

   notif = naughty.notify({text="foo", timeout = 0}).id
   notif2 = naughty.notify({text="foo2", timeout = 0,  replace_id = notif}).id
   notif3 = naughty.notify({text="foo3", timeout = 0,  replace_id = notif2}).id
   
end
