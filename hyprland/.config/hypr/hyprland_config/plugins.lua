if hl.plugin.scrolloverview ~= nil then
  hl.config({
    plugin = {
      scrolloverview = {
        gesture_distance = 300,
        scale            = 0.5,
        workspace_gap    = 100,
        layout           = "vertical",
        wallpaper        = 0,
        blur             = false,

        shadow = {
          enabled        = false,
          range          = 50,
          render_power   = 3,
          color          = "rgba(ee1a1a1a)",
        },
      },
    },
  })

  hl.bind(_G.mainMod.." + ESCAPE", hl.plugin.scrolloverview.overview("toggle"))
  hl.define_submap("scrolloverview", function()
    hl.bind("H",   hl.plugin.scrolloverview.navigate("left"))
    hl.bind("L",  hl.plugin.scrolloverview.navigate("right"))
    hl.bind("K",     hl.plugin.scrolloverview.navigate("up"))
    hl.bind("J",   hl.plugin.scrolloverview.navigate("down"))
    hl.bind("RETURN", hl.plugin.scrolloverview.overview("off"))
    hl.bind("ESCAPE", hl.plugin.scrolloverview.overview("off"))
    hl.bind(_G.mainMod.." + ESCAPE", hl.plugin.scrolloverview.overview("off"))
    hl.bind("mouse:273", hl.dsp.exec_cmd(_G.scripts_location.."advance_focus.sh right"), { mouse = true })
    hl.bind("mouse:272", function()
      hl.plugin.scrolloverview.overview("select")
      hl.plugin.scrolloverview.window("select")
      hl.plugin.scrolloverview.overview("off")
    end, { mouse = true })
  end)
end
