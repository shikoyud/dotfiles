hl.window_rule({
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

local floatty = "kitty|org.pulseaudio.pavucontrol"

for ws = 1, 20 do
  local laptop = ws > 10
  local default = ws == 1 or ws == 11

  hl.workspace_rule({
    workspace = tostring(ws),
    monitor   = laptop and "eDP-1" or "HDMI-A-1",
    default   = default
  })

  hl.window_rule({
    name      = "floatty_" .. ws,
    match     = {
      class        = floatty,
      workspace    = tostring(ws),
    },
    animation = "gnomed",
    float     = true,
    size      = { 1300, 800 },
  })
end
