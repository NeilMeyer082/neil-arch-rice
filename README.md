# ❄️ Arch Linux Rice Framework

An automated, Ansible-driven deployment framework for setting up a modern, visual **Arch Linux** desktop environment with a modular selection of desktop components.

This framework features an interactive TUI installer, customizable dynamic themes via Jinja2 templating, automated AUR helper integration, and structured Ansible roles covering every aspect of the desktop stack.

---

## 🎯 Design Philosophy: Plumb the Desktop, Leave You King of Your Castle

This framework follows a strict **modular, window-manager-focused design philosophy**:

* **Automated Plumbing, Zero Application Bloat:** The framework exists solely to automate the low-level, tedious mechanics of desktop creation—graphics driver detection, DRM/KMS modesetting, PipeWire audio routing, display manager sessions, font fallbacks, and rendering daemons. 
* **No Bundled User Applications:** The playbook intentionally **does not install web browsers** (e.g., Firefox, Chromium, Brave), media players, office suites, or text editors. You get a clean, functional starting line without un-installing someone else's opinionated defaults.
* **Custom Window Managers, Not Monolithic DEs:** This framework is built specifically for **modular Window Manager / Wayland compositor setups** (Hyprland, Sway, i3). If you are looking for a traditional, out-of-the-box Desktop Environment like **KDE Plasma**, **GNOME**, or **Cinnamon**, we recommend using standard `archinstall` directly.
* **A Working Base for Learning to Rice:** Skip the frustrating blank black screen and configuration burnout. This framework drops human-readable Jinja2 templates straight into your `~/.config/` directory—giving you a fully functional, styled desktop on Day 1 that serves as a safe playground for you to tweak, customize, and build your ricing skills.

---

## 📸 Overview

* **OS Target:** Arch Linux (x86_64)
* **Configuration Engine:** Ansible (`site.yml`)
* **Interactive Frontend:** TUI powered by `dialog`
* **Target Hardware:** Native bare-metal (AMD / Intel iGPU / NVIDIA) or Virtual Machines

---

## 🛠️ System Architecture & Roles

The framework modularizes system setup into **6 core Ansible roles**:

```text
arch-rice/
├── bootstrap.sh            # Dialog TUI installer & user variable generator
├── site.yml                # Primary Ansible playbook entrypoint
├── vars/
│   └── user_choices.yml    # Auto-generated choices from bootstrap TUI
└── roles/
    ├── system_base         # Pacman mirrors, multilib, AUR helper (yay), audio tools & base tools
    ├── desktop             # GPU detection (NVIDIA/AMD/Intel), Display Managers, & WMs
    ├── bar                 # Status bar framework (Waybar, Polybar, AGS, Eww, Quickshell, Fabric)
    ├── launcher            # Application launchers & logout menus (Rofi, Fuzzel, Wofi, wlogout)
    ├── terminal            # Terminal emulators, shells, prompts, multiplexers, & fetches
    └── theme               # GTK/X11 theme engines, icons (Papirus/Candy/etc.), cursors, & wallpapers
```

## 🚀 Quick Start (Bare-Metal & Local VM)

### 1\. Prerequisites

Before running the deployment, ensure your base Arch Linux system is installed and updated:

    sudo pacman -Syu --needed git ansible dialog
    

### 2\. Clone the Repository

    git clone https://github.com/NeilMeyer082/neil-arch-rice.git
    cd neil-arch-rice
    

### 3\. Launch the Interactive Installer

Run the bootstrap script to launch the `dialog` TUI:

    chmod +x bootstrap.sh
    ./bootstrap.sh
    
Follow the on-screen options to select your preferred packages, fonts, desktop themes etc. The TUI automatically writes your selections to `vars/user_choices.yml` and launches the Ansible execution pipeline.
