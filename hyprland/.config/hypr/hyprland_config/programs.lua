Terminal         = "kitty"
FileManager      = "nautilus"
Menu             = "nc -U /run/user/1000/walker/walker.sock"
ClipboardManager = "walker -m clipboard"
SymbolsPicker    = "walker -m symbols"
Runner           = "walker -m runner"
FileBrowser      = "walker -m files"
Websearch        = "walker -m websearch"
PacMan           = "walker -m archlinuxpkgs"
ToDo             = "walker -m todo"
PlayerControl    = "walker -m playerctl"
WindowManager    = "walker -m windows"

Screenshot       = 'GEOM="$(slurp)" && sleep 0.5 && grim -g "$GEOM" - | swappy -f -'
Snipping         = 'GEOM="$(slurp -d)" && sleep 0.5 && grim -g "$GEOM" - | wl-copy'


QuitHyprland     = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"

RaiseVolume      = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
LowerVolume      = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
AudioMute        = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
MicMute          = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

AudioNext        = "playerctl next"
AudioPrev        = "playerctl previous"
AudioPlayPause   = "playerctl play-pause"
