local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()

local mytheme = {}

mytheme.name = "miami"

-- xrdb variables and fallback
mytheme.x = {
  background = xrdb.color0 or "#121212",
  surface = xrdb.color0 or "#000000",
  dark_primary = "#30222C", -- branded dark surface

  primary = xrdb.color6 or "#9afff9", -- cyan
  primary_variant_1 = xrdb.color2 or "#88EFAC", -- primary analog
  primary_variant_2 = xrdb.color4 or "#808FEC", -- primary analog

  secondary = xrdb.color5 or "#E686AC", -- magenta
  secondary_variant_1 = xrdb.color3 or "#DBA68C", -- secondary analog
  secondary_variant_2 = xrdb.color13 or "#EB86FC", -- secondary analog

  error = xrdb.color9 or "#CF6673",
  error_variant_1 = xrdb.color9 or "#BFA6B3",

  on_background = xrdb.color15 or "#ffffff", -- white
  on_surface = xrdb.color15, -- white
  on_primary = xrdb.color0, -- black
  on_secondary = xrdb.color0,  -- black
  on_error = xrdb.color0, -- white
  on_surface = xrdb.color15,
}

-- fonts
mytheme.f = {
  h1 = "Space Mono Nerd Font Complete Mono 60", -- used rarely on big icon or big title
  h4 = "Space Mono Nerd Font Complete 32",
  h5 = "Material Design Icons Regular 20", -- icon for h6
  h6 = "Space Mono Nerd Font Complete 20",
  subtile_1 = "Space Mono Nerd Font Complete Mono 13", -- used on text list
  body_1 = "Space Mono Bold Nerd Font Complete 16", -- used on text body title
  body_2 = "Space Mono Nerd Font Complete 14", -- used on text body
  -- for button, don't use a Mono variant because icons are too small
  -- issue: https://github.com/Powerlevel9k/powerlevel9k/issues/430
  icon = "Material Design Icons Regular 15", -- used for icon
  button = "Space Mono Nerd Font Complete 14", -- used on text button
  caption = "Space Mono Bold Nerd Font Complete 12", -- used on annotation
  overline = "Space Mono Nerd Font Complete Mono 10",
}

-- text emphasis
-- https://material.io/design/color/dark-theme.html#ui-application
mytheme.t = {
  high = 87,
  medium = 60,
  disabled = 38
}

-- elevation overlay transparency in hexa code
-- https://material.io/design/color/dark-theme.html#properties
mytheme.e = {
  dp00 = "00",
  dp01 = "0D",
  dp02 = "12",
  dp03 = "14",
  dp04 = "17",
  dp06 = "1C",
}

return mytheme
