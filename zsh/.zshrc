# ── Environment ─────────────────────────────────────────────
export QT_IM_MODULE=fcitx5
export XMODIFIERS=fcitx5
export SDL_IM_MODULE=fcitx5
export INPUT_METHOD=fcitx5
export EDITOR=nvim

typeset -U path
path+=("$HOME/.local/bin")

alias nc=ncat
alias v=nvim
alias ff=fastfetch

# ── Plugins on non-NixOS machines (e.g. WSL) ────────────────
# On NixOS, /etc/zshrc already loads these (programs.zsh in common.nix)
if [[ ! -e /etc/NIXOS ]]; then
  autoload -Uz compinit && compinit
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  for p in /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
           /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
    [[ -r $p ]] && source $p
  done
fi

if command -v starship >/dev/null && [[ -z $STARSHIP_SHELL ]]; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi
