local naughty = require("naughty")
local beautiful = require("beautiful")

local noti = {}

function noti.info(msg)
  naughty.notify({ 
    text = msg
  })
end

function noti.good(msg)
  naughty.notify({ 
    text = msg
  })
end

function noti.warn(msg)
  naughty.notify({ 
    title = "Warn",
    text = "WARN: "..msg
  })
end

return noti
