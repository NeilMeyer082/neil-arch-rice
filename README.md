# ❄️ Arch Linux Rice Framework

An automated, Ansible-driven deployment framework for setting up a modern, visual **Arch Linux** desktop environment with a modular selection of desktop components.

This framework features an interactive TUI installer, customizable dynamic themes via Jinja2 templating, automated AUR helper integration, and structured Ansible roles covering every aspect of the desktop stack.

---

## 🎯 Design Philosophy: Plumb the Desktop, Leave You King of Your Castle

This framework follows a strict **modular, window-manager-focused design philosophy**:

* **Automated Plumbing, Zero Application Bloat:** 

The framework exists solely to automate the low-level, tedious mechanics of desktop creation—graphics driver detection, DRM/KMS modesetting, PipeWire audio routing, display manager sessions, font fallbacks, and rendering daemons. 

* **No Bundled User Applications:** 

The playbook intentionally **does not install web browsers** (e.g., Firefox, Chromium, Brave), media players, office suites, or text editors. You get a clean, functional starting line without un-installing someone else's opinionated defaults.

* **Custom Window Managers, Not Monolithic DEs:** 

This framework is built specifically for **modular Window Manager / Wayland compositor setups** (Hyprland, Sway, i3). If you are looking for a traditional, out-of-the-box Desktop Environment like **KDE Plasma**, **GNOME**, or **Cinnamon**, we recommend using standard `archinstall` directly.

* **A Working Base for Learning to Rice:** 

Skip the frustrating blank black screen and configuration burnout. This framework drops human-readable Jinja2 templates straight into your `~/.config/` directory—giving you a fully functional, styled desktop on Day 1 that serves as a safe playground for you to tweak, customize, and build your ricing skills.

---

## 🍱 Architectural Philosophy: Omakase vs. Okonomi (お好み)

Projects like Omarchy are built on an **omakase** philosophy—the Japanese culinary term meaning *"I'll leave it up to the chef."* The creator picks the editor, browser, keybindings, fonts, terminal, and workflow. If you like their exact taste, it’s great. If you disagree with 20% of their choices, you spend hours fighting their opinionated defaults and overriding their scripts.   

This framework's philosophy is called **Okonomi (お好み)**—the direct linguistic antonym.

If *Omakase* means *"I'll leave it up to the chef,"* its literal culinary opposite in Japanese is *Okonomi*, which translates to **"as you like it"** or **"to one's preference"** (as seen in *Okonomiyaki*, the savory pancake where you choose all your own ingredients).

In software engineering, the **Okonomi paradigm** means:

* **Zero Enforced Defaults:** 

The tool provides a clean runtime engine or installer, but expects the developer to bring their own choices.  

* **À La Carte Construction:** 

You build your environment piece by piece rather than accepting a pre-packaged bundle.  

### The "UNIX Philosophy" & "Mechanism, Not Policy"

In operating system design, this exact concept is officially known as the **Separation of Mechanism and Policy**:

* **Policy (Omarchy / Omakase approach):** 

Decides *what* should be done and *how* the user must experience it (e.g., *"We use Firefox, we use Neovim, we use these exact keybinds, and we hardcode the theme"*).

* **Mechanism (Our Framework / Okonomi approach):** 

Provides the *tools and infrastructure* to do the work without dictating how they must be used (e.g., *"Here is a clean installer, automatic GPU detection, and a `dialog` menu—you decide which window manager and bar to deploy"*).

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
