set -g fish_greeting
set -x GTK_IM_MODULE = fcitx5
set -x QT_IM_MODULE = fcitx5
set -x XMODIFIERS =@im =fcitx5
set -x INPUT_METHOD = fcitx5
set -x SDL_IM_MODULE = fcitx5

alias vim nvim
alias v nvim
starship init fish | source
zoxide init --cmd cd fish | source
