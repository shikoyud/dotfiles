hl.config({
  general = {
    border_size       = 2,
    layout            = "scrolling",
    no_focus_fallback = true,
  },
  decoration = {
    rounding       = 20,
    rounding_power = 5,
    shadow = {
      range = 25,
      render_power = 3,
      color = "rgba(1a1b2699)",
    },
    blur = {
      size = 10,
      passes = 3,
      noise = 0.025,
      vibrancy_darkness = 1,
      input_methods = true,
    },
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

require("hyprland_config.animations")
