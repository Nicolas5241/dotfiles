#!/usr/bin/env bash
set -e

if [[ "$EUID" -eq 0 && "${1:-}" != "root" && "${FLAG:-}" != "1" ]]; then
    cat >&2 <<'EOF'
This script cannot run as root unless you pass "root" as the first argument.
If you are not root and tried to run this script using "sudo", run this script normally as it automatically asks for permissions.
Example:
  ./install.sh root
EOF
    exit 1
fi

if [[ "${FLAG:-}" != "1" ]]; then
    echo "Re-running via sudo -E..."
    exec sudo -E env FLAG=1 bash "$0" "$@"
fi

echo "Running with FLAG=1"
echo "EUID=$EUID, first argument=${1:-}"

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
link "$DOTFILES_DIR/fish" "$HOME/.config/fish"

link "$DOTFILES_DIR/xdg-desktop-portal/hyprland-portals.conf" "/usr/share/xdg-desktop-portal/hyprland-portals.conf"
link "$DOTFILES_DIR/xdg-desktop-portal/niri-portals.conf" "/usr/share/xdg-desktop-portal/niri-portals.conf"

./colemak-dh/build_xkb.sh
./colemak-dh/xkb/install-system.sh

echo "Done ✅"
