# ❄️ Arch Linux Rice Framework

An automated, Ansible-driven deployment framework for setting up a modern, visual **Arch Linux** desktop environment with a modular selection of desktop components.

This framework features an interactive TUI installer, customizable dynamic themes via Jinja2 templating, automated AUR helper integration, and structured Ansible roles covering every aspect of the desktop stack.

---

## 🎯 Design Philosophy: Pure Desktop Environment

This framework follows a strict **DE-only design philosophy**:

* **Automated Desktop Environment, Zero Bloat:** The framework exists solely to automate the installation and styling of your Desktop Environment / Window Manager stack (compositors, status bars, launchers, fonts, cursors, and GTK themes).
* **No Bundled User Applications:** The playbook intentionally **does not install web browsers** (e.g., Firefox, Chromium, Brave), media players, office suites, or user applications. 
* **User Control First:** You get a clean, functional, and visually polished desktop experience out of the box, leaving complete freedom for you to install your preferred user-space applications post-setup.

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
