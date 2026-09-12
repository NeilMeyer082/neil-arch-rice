    # ❄️ Arch Linux Rice Framework
    
    An automated, Ansible-driven deployment framework for setting up a modern, visual **Arch Linux** desktop environment giving you all the various major ricing options.
    
    This framework features an interactive TUI installer, customizable dynamic themes via Jinja2 templating, automated AUR helper integration, and structured Ansible roles covering every aspect of the desktop stack.
    
    ---
    
    ## 📸 Overview
    
    * **OS Target:** Arch Linux (x86_64)
    * **Configuration Engine:** Ansible (`playbook.yml`)
    * **Interactive Frontend:** TUI powered by `dialog`
    * **Target Hardware:** Native bare-metal (AMD / Intel iGPU / Nvidia) or Virtual Machines
    
    ---
    
    ## 🛠️ System Architecture & Roles
    
    The framework modularizes system setup into **19 distinct Ansible roles**:
    
    ```text
    arch-rice/
    ├── bootstrap.sh            # Main TUI installer & launcher
    ├── playbook.yml            # Primary Ansible entrypoint
    ├── vars/
    │   └── user_choices.yml    # Auto-generated choices from TUI
    └── roles/
        ├── system_base         # Core packages, multilib, base utilities
        ├── yay                 # AUR helper compilation and configuration
        ├── display_manager     # SDDM / GDM setup with custom themes
        ├── hyprland            # Hyprland compositor & keybind configuration
        ├── waybar              # Dynamic status bar configuration
        ├── rofi                # Application launcher & power menu
        ├── hyprpaper           # Wallpaper management service
        ├── hyprlock            # Screen locking & PAM authentication
        ├── hypridle            # Power management & idle daemons
        ├── kitty               # Terminal emulator configuration & fonts
        ├── starship            # Cross-shell prompt customization
        ├── zsh                 # Shell aliases, plugins (autosuggestions/syntax)
        ├── neovim              # Editor setup & LSP integration
        ├── fastfetch           # System information display
        ├── audio               # Pipewire, Wireplumber, & pavucontrol
        ├── bluetooth           # Bluez & Blueman manager service
        ├── fonts               # Nerd Fonts (JetBrainsMono, FontAwesome)
        ├── theme               # GTK/Qt themes, icon packs, and cursor icons
        └── gaming              # Steam, Lutris, Wine-staging, and DXVK
    

## 🚀 Quick Start (Bare-Metal & Local VM)

### 1\. Prerequisites

Before running the deployment, ensure your base Arch Linux system is installed and updated:

    sudo pacman -Syu --needed git ansible dialog
    

### 2\. Clone the Repositoryh

    git clone [https://github.com/NeilMeyer082/neil-arch-rice.git](https://github.com/NeilMeyer082/neil-arch-rice.git)
    cd neil-arch-rice
    

### 3\. Launch the Interactive Installer

Run the bootstrap script to launch the `dialog` TUI:

    chmod +x bootstrap.sh
    ./bootstrap.sh
    
Follow the on-screen options to select your preferred packages, fonts, desktop themes, and extra software suites (e.g., Gaming stack). The TUI automatically writes your selections to `vars/user_choices.yml` and launches the Ansible execution pipeline.
