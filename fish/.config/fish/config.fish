set -g fish_greeting
set -x EDITOR nvim

alias v nvim
alias ff fastfetch

starship init fish | source
zoxide init --cmd cd fish | source
