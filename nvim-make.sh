#!/usr/bin/env bash

set -e

cd "$HOME/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim"
make
cd "$HOME/.local/share/nvim/site/pack/core/opt/LuaSnip"
make
