set -g fish_greeting
set -x QT_IM_MODULE fcitx5
set -x XMODIFIERS fcitx5
set -x INPUT_METHOD fcitx5
set -x SDL_IM_MODULE fcitx5
set -x NVD_BACKEND direct
set -x LIBVA_DRIVER_NAME nvidia
set -x __GLX_VENDOR_LIBRARY_NAME nvidia
set -x GBM_BACKEND nvidia-drm
set -x ENABLE_VULKAN_RENDERER 1
alias vim nvim
alias v nvim
starship init fish | source
zoxide init --cmd cd fish | source
