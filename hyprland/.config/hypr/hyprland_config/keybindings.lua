_G.scripts_location = "~/.config/hypr/scripts/"
_G.mainMod = "SUPER"


hl.bind(mainMod .. " + CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd(QuitHyprland))


-- Launch applications

hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd(Menu))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(FileManager))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd(ClipboardManager))
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd(Websearch))
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(ToDo))
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd(PlayerControl))
hl.bind(mainMod .. " + TAB",       hl.dsp.exec_cmd(WindowManager))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(PacMan))
hl.bind(mainMod .. " + code:60",   hl.dsp.exec_cmd(SymbolsPicker))
hl.bind(mainMod .. " + code:61",   hl.dsp.exec_cmd(FileBrowser))
hl.bind(mainMod .. " + code:148",  hl.dsp.exec_cmd(Runner))
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(Terminal))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(Snipping))
hl.bind("Print",                   hl.dsp.exec_cmd(Screenshot))
hl.bind("CTRL + SHIFT + code:148", hl.dsp.exec_cmd(scripts_location.."toggle_input_method.sh"))

-- Handle windows & workspaces

hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + H",         hl.dsp.exec_cmd(scripts_location.."advance_focus.sh left"))
hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd(scripts_location.."advance_focus.sh right"))
hl.bind(mainMod .. " + K",         hl.dsp.exec_cmd(scripts_location.."advance_focus.sh up"))
hl.bind(mainMod .. " + J",         hl.dsp.exec_cmd(scripts_location.."advance_focus.sh down"))

hl.bind("ALT + TAB",               hl.dsp.exec_cmd(scripts_location.."alt_tab.sh"))
hl.bind(mainMod .. "+ F",          hl.dsp.window.center())

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("swapcol l"))

hl.bind(mainMod .. " + code:21",   hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + code:20",   hl.dsp.layout("colresize -conf"))

hl.bind(mainMod .. " + SHIFT + code:59",   hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. " + SHIFT + code:60",   hl.dsp.layout("consume_or_expel next"))

hl.bind(mainMod .. "+ F11",        hl.dsp.window.fullscreen())

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = "r~"..i}),        { submap_universal = true} )
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "r~"..i }), { submap_universal = true} )
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- MEDIA

hl.bind("code:148",             hl.dsp.exec_cmd(scripts_location.."toggle_output_device.sh"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(RaiseVolume), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(LowerVolume), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(AudioMute),   { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(MicMute),     { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(AudioNext),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(AudioPrev),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(AudioPlayPause),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(AudioPlayPause),  { locked = true })
