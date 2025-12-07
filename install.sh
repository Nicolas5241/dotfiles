#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    echo "Removing existing symlink: $dst"
    rm "$dst"

  elif [ -e "$dst" ]; then
    backup="$dst.backup.$(date +%s)"
    echo "Backing up existing path to: $backup"
    mv "$dst" "$backup"
  fi

  ln -s "$src" "$dst"
  echo "Linked $dst → $src"
}

mkdir -p "$HOME/.config"

# === Your links ===
link "$DOTFILES_DIR/nvim"   "$HOME/.config/nvim"
link "$DOTFILES_DIR/fuzzel" "$HOME/.config/fuzzel"
link "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"
link "$DOTFILES_DIR/niri" "$HOME/.config/niri"
link "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"

./colemak-dh/build_xkb.sh
./colemak-dh/xkb/install-system.sh

echo "Done ✅"
