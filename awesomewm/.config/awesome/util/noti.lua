local naughty = require("naughty")

local noti = {}

-- called snackbars in material, low emphasis
-- https://material.io/components/snackbars/#specs
function noti.info(msg)
  naughty.notify({ 
    text = msg,
    position = "bottom_middle",
    preset = naughty.config.presets.low
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
