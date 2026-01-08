#!/usr/bin/env bash

set -euo pipefail

window_managers=()

read -rp "Install niri? [y/N] " install_niri
if [[ "$install_niri" =~ ^[Yy]$ ]]; then
  window_managers+=(niri xdg-desktop-portal-gnome xdg-desktop-portal-gtk)
fi

read -rp "Install Hyprland? [y/N] " install_hyprland
if [[ "$install_hyprland" =~ ^[Yy]$ ]]; then
  window_managers+=(hyprland xdg-desktop-portal-hyprland)
fi

aur_helpers=(
    paru yay pikaur trizen
)

shells=(
    fish
)

wayland=(
  swaybg waybar grim slurp wl-clipboard
)

apps=(
  kitty fuzzel dolphin
)

desktop=(
  qt5ct dunst kwallet network-manager-applet
)

misc=(
    brightnessctl polkit-kde-agent archlinux-xdg-menu
)

aur_packages=(
    clipman
)

aur_bin_pkg_pairs=(
  "clipman=clipman"
)

echo "Installing packages with pacman"
sudo pacman -S --needed \
  "${window_managers[@]}" \
  "${wayland[@]}" \
  "${apps[@]}" \
  "${desktop[@]}" \
  "${misc[@]}" \
  "${shells[@]}"

aur_install_success=false

echo "Trying AUR helpers"
for helper in "${aur_helpers[@]}"; do
  command -v "$helper" >/dev/null || continue
  echo "Found AUR helper: $helper"
  "$helper" -S --needed "${aur_packages[@]}" && { aur_install_success=true; break; }
done

origin_directory=$PWD
trap 'cd "$origin_directory"' EXIT

aur_packages_missing=()

aur_packages_location_relative=.aur_packages

if ! $aur_install_success; then
    echo "No AUR helper found, installing manually"

    mkdir -p "$aur_packages_location_relative"

    for pair in "${aur_bin_pkg_pairs[@]}"; do
        bin=${pair%%=*}
        pkg=${pair#*=}

        command -v "$bin" >/dev/null || aur_packages_missing+=("$pkg")
    done

    pushd "$aur_packages_location_relative" >/dev/null 2>&1
    for package in "${aur_packages_missing[@]}"; do
        echo "Cloning $package"
        git clone "https://aur.archlinux.org/$package.git"
    done
    for package in "${aur_packages_missing[@]}"; do
        echo "Building $package"
        pushd "$package" >/dev/null 2>&1
        makepkg -si --needed --noconfirm
        popd >/dev/null 2>&1
    done
fi
