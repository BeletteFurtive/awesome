local wibox = require("wibox")
local awful = require("awful")
local naughty   = require("naughty")


volumeimage = wibox.widget.imagebox()

volumewidget = wibox.widget.textbox()
volumewidget:set_align("right")
 
function update_volume(widget, mute)
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
      if mute then
         naughty.notify({
               title="Volume : ",
               icon=awful.util.getdir("config") .. "/images/volume_active.png",
               text="Actif"})
      end
   else
      volumeimage:set_image(awful.util.getdir("config") .. "/images/volume_mute.png")
      if mute then
         naughty.notify({
               title="Volume : ",
               icon=awful.util.getdir("config") .. "/images/volume_mute.png",
               text="Mute"})
      end
         
   end

   widget:set_markup(volumestring)
      
end


function notify_volume(status)

   indic, volumestatus = update_volume(volumewidget)
   
   if status=="up" then
      naughty.notify({
            title="Volume : ",
            icon=awful.util.getdir("config") .. "/images/volume_active.png",
            text=indic})
   elseif status=="down" then
      naughty.notify({
            title="Volume : ",
            icon=awful.util.getdir("config") .. "/images/volume_active.png",
            text=indic})
   elseif status=="mute" then
      if string.find(volumestatus, "on", 1, true) then
         naughty.notify({
            title="Volume : ",
            icon=awful.util.getdir("config") .. "/images/volume_active.png",
            text="Actif"})
      else
         naughty.notify({
            title="Volume : ",
            icon=awful.util.getdir("config") .. "/images/volume_mute.png",
            text="Mute"})
      end
   end
   
   
end
update_volume(volumewidget)
 
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volumewidget) end)
mytimer:start()
