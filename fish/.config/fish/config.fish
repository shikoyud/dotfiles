set -g fish_greeting
set -x QT_IM_MODULE fcitx5
set -x XMODIFIERS fcitx5
set -x SDL_IM_MODULE fcitx5
set -x INPUT_METHOD fcitx5

alias v nvim
alias ff fastfetch

starship init fish | source
zoxide init --cmd cd fish | source
