#!/usr/bin/env bash
set -e

# Always operate from the repo root, regardless of where the user invoked us.
# Fixes "playbook.yml could not be found" when run from $HOME or elsewhere.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

# Ensure dependencies are available for the installer menu
sudo pacman -Sy --needed --noconfirm dialog ansible git

# Ensure target directory for variables exists
mkdir -p "${SCRIPT_DIR}/vars"

# -----------------------------------------------------------------------------
# 1. WINDOW MANAGER SELECTION
# -----------------------------------------------------------------------------
WM_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Window Manager / Compositor Selection " \
  --menu "Choose your preferred layout manager:" 18 65 9 \
  "hyprland" "[Wayland] Hyprland  - Dynamic tiling & fluid animations" \
  "sway" "[Wayland] Sway      - i3-compatible tiling compositor" \
  "niri" "[Wayland] Niri      - Modern scrollable infinity tiling" \
  "river" "[Wayland] River     - Dynamic tiling with custom layouts" \
  "i3" "[X11]     i3-wm     - Benchmark manual tiling WM" \
  "bspwm" "[X11]     bspwm     - Binary space partitioning WM" \
  "awesome" "[X11]     AwesomeWM - Lua-configurable dynamic WM" \
  "qtile" "[X11/WL]  Qtile     - Python-configured tiling WM" \
  "openbox" "[X11]     Openbox   - Lightweight stacking/floating WM" \
  3>&1 1>&2 2>&3)

if [ -z "$WM_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

# Initialize/Overwrite user_choices.yml with the first choice
cat <<EOF >"${SCRIPT_DIR}/vars/user_choices.yml"
selected_wm: "${WM_CHOICE}"
EOF

# -----------------------------------------------------------------------------
# 2. COLOR SCHEME SELECTION
# -----------------------------------------------------------------------------
THEME_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Color Scheme Selection " \
  --menu "Choose your desktop color palette:" 18 65 10 \
  "catppuccin-mocha" "Catppuccin Mocha - Soothing pastel dark" \
  "gruvbox-dark" "Gruvbox Dark     - Retro groove earthy tones" \
  "nord" "Nord             - Arctic north-bluish palette" \
  "everforest-dark" "Everforest Dark  - Pleasant green forest scheme" \
  "dracula" "Dracula          - Classic dark spooky purple/pink" \
  "rose-pine" "Rosé Pine        - Soho minimalist dark pine" \
  "tokyo-night" "Tokyo Night      - Dark neon night lights" \
  "kanagawa" "Kanagawa         - Wave-painting inspired dark" \
  "sweet-dark" "Sweet Dark       - Colorful candy neon" \
  "catppuccin-latte" "Catppuccin Latte - Soothing pastel light" \
  3>&1 1>&2 2>&3)

if [ -z "$THEME_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_theme: \"${THEME_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 3. WALLPAPER DAEMON SELECTION
# -----------------------------------------------------------------------------
WALLPAPER_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Wallpaper Utility Selection " \
  --menu "Choose your wallpaper manager:" 15 65 4 \
  "hyprpaper" "[Wayland] Hyprpaper - Fast, IPC-controlled daemon" \
  "swaybg" "[Wayland] Swaybg    - Lightweight, minimal static wallpaper tool" \
  "awww" "[Wayland] Awww      - Animated GIF & image daemon with runtime transitions" \
  "feh" "[X11]     Feh       - Classic lightweight X11 wallpaper setter" \
  3>&1 1>&2 2>&3)

if [ -z "$WALLPAPER_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_wallpaper_daemon: \"${WALLPAPER_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 4. UI SANS-SERIF FONT SELECTION
# -----------------------------------------------------------------------------
SANS_FONT_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " System UI Font Selection " \
  --menu "Choose your primary Sans-Serif font for UI & bars:" 16 65 5 \
  "inter" "Inter       - Ultra-clean modern interface font" \
  "roboto" "Roboto      - Modern geometric Android font" \
  "ubuntu" "Ubuntu      - Distinctive rounded brand font" \
  "open-sans" "Open Sans   - Highly readable neutral sans-serif" \
  "dejavu-sans" "DejaVu Sans - Universal fallback & classic sans" \
  3>&1 1>&2 2>&3)

if [ -z "$SANS_FONT_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_sans_font: \"${SANS_FONT_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 5. TERMINAL MONOSPACE FONT SELECTION
# -----------------------------------------------------------------------------
MONO_FONT_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Terminal / Code Font Selection " \
  --menu "Choose your monospace font with programming ligatures:" 18 65 6 \
  "jetbrains" "JetBrains Mono - Developer font with clean ligatures" \
  "firacode" "Fira Code      - Popular coding font with rich ligatures" \
  "cascadia" "Cascadia Code  - Modern Microsoft terminal font" \
  "iosevka" "Iosevka        - Ultra-narrow versatile monospace font" \
  "victor" "Victor Mono    - Cursive italics with programming ligatures" \
  "dejavu" "DejaVu Mono    - Classic crisp monospaced typeface" \
  3>&1 1>&2 2>&3)

if [ -z "$MONO_FONT_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_mono_font: \"${MONO_FONT_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 6. STATUS BAR & DESKTOP SHELL SELECTION
# -----------------------------------------------------------------------------
BAR_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Status Bar & Desktop Shell Selection " \
  --menu "Choose your status bar or widget framework:" 18 68 7 \
  "waybar" "[Wayland] Waybar     - GTK JSONC/CSS bar (Recommended for Wayland)" \
  "polybar" "[X11]     Polybar    - Lightweight INI bar (Recommended for X11)" \
  "ags" "[WL/X11]  AGS        - Modern TypeScript/GTK desktop shell framework" \
  "eww" "[WL/X11]  Eww        - ElKowars Wacky Widgets (Yuck + CSS)" \
  "quickshell" "[WL/X11]  Quickshell - Fast QtQuick/QML desktop shell toolkit" \
  "fabric" "[WL/X11]  Fabric     - Python/GTK framework for custom widgets" \
  "none" "[Any]     None       - Minimalist setup without a bar" \
  3>&1 1>&2 2>&3)

if [ -z "$BAR_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_bar: \"${BAR_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 7. CURSOR THEME SELECTION
# -----------------------------------------------------------------------------
CURSOR_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Cursor Theme Selection " \
  --menu "Choose your primary cursor theme:" 20 70 12 \
  "bibata-ice"        "Bibata Modern Ice      - Material rounded white cursor" \
  "bibata-amber"      "Bibata Modern Amber    - Material rounded amber cursor" \
  "bibata-classic"    "Bibata Modern Classic  - Material rounded dark cursor" \
  "breezex"           "BreezeX Light          - Extended KDE Plasma crisp cursor" \
  "apple"            "Apple macOS            - macOS Monterey style cursor" \
  "vimix"            "Vimix                  - Modern sleek material design cursor" \
  "catppuccin-mocha" "Catppuccin Mocha       - Darkest pastel theme cursor" \
  "catppuccin-macchiato" "Catppuccin Macchiato - Medium dark pastel cursor" \
  "catppuccin-frappe" "Catppuccin Frappe      - Muted dark pastel cursor" \
  "catppuccin-latte"  "Catppuccin Latte       - Light theme pastel cursor" \
  "phinger-dark"     "Phinger Dark           - Overpriced-style pixel cursor (Dark)" \
  "phinger-light"    "Phinger Light          - Overpriced-style pixel cursor (Light)" \
  3>&1 1>&2 2>&3)

if [ -z "$CURSOR_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_cursor: \"${CURSOR_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 8. ICON THEME SELECTION
# -----------------------------------------------------------------------------
ICON_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Icon Theme Selection " \
  --menu "Choose your primary desktop icon theme:" 16 70 6 \
  "papirus"      "Papirus      - Pixel-perfect flat icons (Auto-recolors)" \
  "candy"        "Candy        - High-vibrancy neon gradient icons" \
  "la-capitaine" "La Capitaine - macOS & Material design inspired icon pack" \
  "flat-remix"   "Flat Remix   - Depth-based material design icons" \
  3>&1 1>&2 2>&3)

if [ -z "$ICON_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_icon_theme: \"${ICON_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 9. APPLICATION LAUNCHER SELECTION
# -----------------------------------------------------------------------------
LAUNCHER_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Application Launcher Selection " \
  --menu "Choose your primary application launcher:" 16 68 5 \
  "rofi" "[WL/X11] Rofi      - Universal customizable launcher & menu engine" \
  "fuzzel" "[Wayland] Fuzzel   - Minimalist, ultra-fast wlroots dmenu launcher" \
  "wofi" "[Wayland] Wofi     - Lightweight GTK-based Wayland launcher" \
  "ulauncher" "[WL/X11] Ulauncher - Python/GTK launcher with extensions" \
  "vicinae" "[WL/X11] Vicinae   - Modern Raycast-inspired extensible runner" \
  3>&1 1>&2 2>&3)

if [ -z "$LAUNCHER_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_launcher: \"${LAUNCHER_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 10. NOTIFICATION DAEMON SELECTION
# -----------------------------------------------------------------------------
NOTIF_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Notification Daemon Selection " \
  --menu "Choose your notification daemon:" 15 68 3 \
  "swaync" "[Wayland] SwayNC - GTK control center panel with widgets & DND" \
  "mako" "[Wayland] Mako   - Ultra-lightweight, minimal Wayland notification daemon" \
  "dunst" "[WL/X11]  Dunst  - Universal, highly customizable notification daemon" \
  3>&1 1>&2 2>&3)

if [ -z "$NOTIF_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_notifications: \"${NOTIF_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 11. LOGOUT MENU SELECTION
# -----------------------------------------------------------------------------
LOGOUT_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Logout Menu Selection " \
  --menu "Choose your session logout / power menu:" 15 68 2 \
  "wlogout" "[Wayland] wlogout - Fullscreen GTK overlay grid with touch/mouse icons" \
  "rofi" "[WL/X11]  Rofi    - Lightweight scriptable dmenu-style power menu" \
  3>&1 1>&2 2>&3)

if [ -z "$LOGOUT_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_logout_menu: \"${LOGOUT_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 12. SCREEN LOCKER SELECTION
# -----------------------------------------------------------------------------
LOCKER_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Screen Locker Selection " \
  --menu "Choose your session screen locker:" 15 68 3 \
  "hyprlock" "[Wayland] Hyprlock         - GPU-accelerated locker with live widgets" \
  "swaylock-effects" "[Wayland] Swaylock-Effects - Custom blur & clock effects locker" \
  "i3lock-color" "[X11]     i3lock-color     - Enhanced X11 screen locker with color rings" \
  3>&1 1>&2 2>&3)

if [ -z "$LOCKER_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_locker: \"${LOCKER_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 13. TERMINAL EMULATOR SELECTION
# -----------------------------------------------------------------------------
TERM_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Terminal Emulator Selection " \
  --menu "Choose your primary terminal emulator:" 16 68 5 \
  "kitty" "[WL/X11] Kitty     - GPU-accelerated, feature-rich terminal (Recommended)" \
  "ghostty" "[WL/X11] Ghostty   - Modern GTK4 GPU-accelerated terminal" \
  "foot" "[Wayland] Foot      - Minimalist, fast, native Wayland terminal" \
  "alacritty" "[WL/X11] Alacritty - High-performance OpenGL terminal" \
  "wezterm" "[WL/X11] WezTerm   - Feature-rich multiplexing GPU terminal" \
  3>&1 1>&2 2>&3)

if [ -z "$TERM_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_terminal: \"${TERM_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 14. SHELL SELECTION
# -----------------------------------------------------------------------------
SHELL_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Interactive Shell Selection " \
  --menu "Choose your primary interactive shell:" 15 68 3 \
  "zsh" "Zsh     - Highly customizable with Zap plugin manager & Starship" \
  "fish" "Fish    - User-friendly shell with out-of-the-box autosuggestions" \
  "nushell" "Nushell - Modern structured-data shell with typed pipelines" \
  3>&1 1>&2 2>&3)

if [ -z "$SHELL_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_shell: \"${SHELL_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 15. SHELL PROMPT SELECTION
# -----------------------------------------------------------------------------
PROMPT_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Shell Prompt Engine Selection " \
  --menu "Choose your shell prompt theme renderer:" 16 68 4 \
  "starship" "[Cross-Shell] Starship      - Fast, modern TOML prompt (Recommended)" \
  "oh-my-posh" "[Cross-Shell] Oh-My-Posh    - Highly customizable segmented prompt engine" \
  "powerlevel10k" "[Zsh Only]    Powerlevel10k - Feature-rich Zsh prompt with Git integration" \
  "pure" "[Zsh/Async]   Pure          - Minimal, clean, and distraction-free prompt" \
  3>&1 1>&2 2>&3)

if [ -z "$PROMPT_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_prompt: \"${PROMPT_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 16. TERMINAL MULTIPLEXER SELECTION
# -----------------------------------------------------------------------------
MUX_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Terminal Multiplexer Selection " \
  --menu "Choose your terminal multiplexer:" 15 68 3 \
  "tmux" "tmux   - Benchmark terminal multiplexer with TPM & status bar" \
  "zellij" "Zellij - Modern workspace tool with layouts, floating panes & tabs" \
  "none" "None   - Skip multiplexer installation" \
  3>&1 1>&2 2>&3)

if [ -z "$MUX_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_multiplexer: \"${MUX_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 17. SYSTEM FETCH UTILITY SELECTION
# -----------------------------------------------------------------------------
FETCH_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " System Fetch Utility Selection " \
  --menu "Choose your CLI system information display tool:" 15 68 4 \
  "fastfetch" "Fastfetch - Blazingly fast, modern C-based tool (Recommended)" \
  "pfetch" "Pfetch    - Lightweight POSIX sh system summary" \
  "nitch" "Nitch     - Minimalist & super-fast system info written in Nim" \
  "hyfetch" "Hyfetch   - Modern Neofetch fork with custom flag/color support" \
  3>&1 1>&2 2>&3)

if [ -z "$FETCH_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_fetch: \"${FETCH_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# -----------------------------------------------------------------------------
# 18. FILE MANAGER SELECTION
# -----------------------------------------------------------------------------
FM_CHOICE=$(dialog --clear --backtitle "Arch Linux Ricing Framework" \
  --title " Graphical File Manager Selection " \
  --menu "Choose your primary graphical file manager:" 16 68 5 \
  "thunar" "Thunar   - Modular GTK file manager with extension support (Recommended)" \
  "nemo" "Nemo     - Feature-rich Cinnamon default file browser" \
  "nautilus" "Nautilus - Clean, modern GNOME file manager" \
  "dolphin" "Dolphin  - Advanced Qt file manager with split-pane view" \
  "pcmanfm" "PCManFM  - Ultra-fast, lightweight desktop file manager" \
  3>&1 1>&2 2>&3)

if [ -z "$FM_CHOICE" ]; then
  echo "Installation cancelled."
  exit 1
fi

echo "selected_file_manager: \"${FM_CHOICE}\"" >>"${SCRIPT_DIR}/vars/user_choices.yml"

# Clear screen and display summary before launching playbook
clear
echo "================================================================="
echo " Selection complete! Saved choices to vars/user_choices.yml"
echo " Launching Ansible execution pipeline..."
echo "================================================================="

# Execute Ansible Playbook
ansible-playbook -K "${SCRIPT_DIR}/playbook.yml"
