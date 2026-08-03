hl.config({
  binds = { scroll_event_delay = 1 },
  input = {
    kb_layout  = "us",
    kb_options = "caps:escape",
    accel_profile = "flat",
    follow_mouse = 0,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})
