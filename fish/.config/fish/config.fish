set -g fish_greeting
set -x QT_IM_MODULE fcitx5
set -x XMODIFIERS fcitx5
set -x SDL_IM_MODULE fcitx5
set -x INPUT_METHOD fcitx5
set -x EDITOR nvim
set -x USBMUXD_SOCKET_ADDRESS "$(ip route list default | awk '{print $3}'):27015"

alias nc ncat

alias v nvim
alias ff fastfetch

starship init fish | source
zoxide init --cmd cd fish | source

# Created by `pipx` on 2026-02-02 07:46:19
set PATH $PATH /home/shiko/.local/bin
