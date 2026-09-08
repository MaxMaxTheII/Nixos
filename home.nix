{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./modules/programs/kitty.nix
#        ./modules/programs/bitwarden-cli.nix
        ./modules/programs/rbw.nix
        ./modules/programs/nvim.nix
        ./modules/programs/zathura.nix
        ./modules/programs/bash.nix
        ./modules/programs/cava.nix
        ./modules/programs/walker.nix
        ./modules/programs/librewolf.nix
        ./modules/programs/fastfetch.nix
        ./modules/programs/vesktop.nix
        ./modules/programs/yazi.nix
        inputs.walker.homeManagerModules.default
        ./modules/desktop/wlogout.nix
        ./modules/desktop/hyprlock.nix
        ./modules/desktop/hyprland.nix
        ./modules/desktop/waybar.nix
    ];
    home.username = "max";
    home.homeDirectory = "/home/max";
    home.stateVersion = "26.05";
    home.sessionVariables = {
        EDITOR = "nvim";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

  # This allows Home Manager to manage itself
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
    #A
    #B
#        bitwarden-desktop
    #C 
    #     cava
    #D 
        (discord.override { withOpenASAR = false; }) # only the icon
    #E
    #F 
#       fastfetch
        file
    #G 
        gdb
        ghidra
        gnome-calculator
    #H   
        htop
        hunspell # libre office- spellchecker
    #    hyprland
        hyprshot
	    hyprshutdown
    #I  
        ipe
        inputs.elephant.packages.${pkgs.system}.elephant-with-providers
    #J
    #K 
    #    kitty
    #L   
        libnotify
        libreoffice-qt
    #M
#        mathematica
    #N  
    #O
    #P   
        playerctl
        poetry
        pwntools
    #Q
    #R
    #S  
        sl
        swayosd # on screen display for sound and light change and client for the change itself
    #T 
        texlab
        texliveFull
        tidal-hifi
    #U
        unzip
    #V  
    #W
        wireshark
        wl-clipboard
        wtype
        wttrbar # weather for waybar
    #X
    #Y  
    #Z
        zathura
        zip
    ];

    stylix.targets = {
        firefox.enable = true;
    };

    xdg.desktopEntries = {
        discord = {
            name = "Discord";
            exec = "vesktop %U";
            icon = "discord"; # This uses the official Discord icon
            genericName = "Internet Messenger";
            categories = [ "Network" "InstantMessaging" "Chat" ];
            terminal = false;
            settings = {
                StartupWMClass = "vesktop"; # Helps Hyprland group the window correctly
            };
        };
        vesktop = {
            name = "Vesktop";
            exec = "vesktop %U";
            noDisplay = true;

        };
        tidal-hifi = {
            name = "Tidal";
            exec = "tidal-hifi --no-sandbox";
            icon = "tidal-hifi";
            genericName = "Music Stream";
            categories = ["AudioVideo" "Audio" "Music" "Network"];
        };
        htop = {
            name = "Htop";
            noDisplay = true;
        };
        kvantummanager = {
            name = "Kvantum Manager";
            noDisplay = true;
        };
        qt5ct = {
            name = "Qt5 Settings";
            noDisplay = true;
        };
        qt6ct = {
            name = "Qt6 Settings";
            noDisplay = true;
        };
        yazi = {
            name = "Yazi";
            noDisplay = true;
        };
    };


    gtk = {
        enable = true;
    };


   
    services.udiskie = {
        enable = true;
        tray = "auto"; # Shows a tray icon in Waybar if nm-applet is running
    };

    services.swayosd.enable = true;
}

