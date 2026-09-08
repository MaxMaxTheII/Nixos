{ config, lib, pkgs, inputs, ... }:

let
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    lua = lib.generators.mkLuaInline;
    dsp = {
        exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
        close = lua "hl.dsp.window.close()";
        exit = lua "hl.dsp.exit()";
        float = lua ''hl.dsp.window.float({ action = "toggle" })'';
        fullscreen = lua "hl.dsp.window.fullscreen()";
        pseudo = lua "hl.dsp.window.pseudo()";
        layout = msg: lua ''hl.dsp.layout("${msg}")'';
        focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
        swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
        toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
        moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
        focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
        moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
        drag = lua "hl.dsp.window.drag()";
        resize = lua "hl.dsp.window.resize()";
        sendshortcut = mod: key: lua ''hl.dsp.send_shortcut({ mods = "${mod}", key = "${key}" })'';
    };

    bind = keys: dispatcher: { _args = [keys dispatcher]; };
    bindOpts = keys: dispatcher: opts: { _args = [keys dispatcher opts]; };

    workspaceBinds = lib.concatMap (i:
        let key = toString (lib.mod i 10);
        in [
          (bind "SUPER + ${key}" (dsp.focusWorkspace i))
          (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
        ]
    ) (lib.range 1 10);

    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
        hyprlock &
        swaybg -i ${config.stylix.image} -m fill &
        nm-applet --indicator &
        udiskie &
        ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    '';
	# ${pkgs.waybar}/bin/waybar &
        #waybar &
    #    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    #    hyprlock &
in
{
    imports = [
        ./nvim.nix
        ./modules/programs/kitty.nix
        ./modules/programs/bash.nix
        ./modules/programs/wlogout.nix
        ./modules/programs/cava.nix
        ./modules/programs/walker.nix
        ./modules/programs/librewolf.nix
        ./modules/programs/fastfetch.nix
#        ./modules/programs/vesktop.nix
        ./modules/programs/yazi.nix
        inputs.walker.homeManagerModules.default
        ./modules/desktop/hyprlock.nix
        ./modules/desktop/waybar.nix
    ];
    home.username = "max";
    home.homeDirectory = "/home/max";
    home.stateVersion = "26.05";
    home.sessionVariables = {
        EDITOR = "nvim";
    };

  # This allows Home Manager to manage itself
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
    #A
    #B
        bitwarden-desktop
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
        vesktop
    #W
        wireshark
        wl-clipboard
        wttrbar # weather for waybar
    #X
    #Y  
    #Z
        zathura
        zip
    ];

    stylix.targets = {
        firefox.enable = true;
        hyprland.enable = true;
        vesktop.enable = true;
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
  #      iconTheme = {
  #          name = "Morewaita-Dark"; # Or another BW theme
            #package = pkgs.papirus-icon-theme;
  #          package = pkgs.morewaita-icon-theme;
  #      };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        settings = {
            monitor = [{
                output = "eDP-1";
                mode = "1920x1080";
                position = "0x0";
                scale = "1.25";
            }];
            config = {
                general = {
                    gaps_in = 0;
                    gaps_out = 2;
                    border_size = 3;
                    col = {
                        active_border = lib.mkForce "rgb(${config.lib.stylix.colors.base0D})";
                        #active_border = lib.mkForce "rgb(${config.lib.stylix.colors.base0D}) rgb(${config.lib.stylix.colors.base0E}) 45deg";
                        inactive_border = lib.mkForce "rgb(${config.lib.stylix.colors.base01})";

                    };
                    layout = "dwindle";
                    # layout = "master";
                    resize_on_border = true;
                    extend_border_grab_area = 20;
                };
                decoration = {
                    rounding = 5;
                    active_opacity = 1.0;
                    inactive_opacity = 1.0;
                    blur = {
                        enabled = true;
                        size = 3;
                        passes = 1;
                        vibrancy = 0.1696;
                    };
                };
                animations = {
                    enabled = true;
                };
                dwindle = {
                    force_split = 2;
                    preserve_split = true;
                };
                cursor = {
                    no_hardware_cursors = 1;# no blinking cursor  
                };
                misc = {
                    force_default_wallpaper = -1;
                    disable_hyprland_logo = true;
                };
                input = {
                    kb_layout = "at";
                    kb_variant = "nodeadkeys";
                    natural_scroll = false;
                    touchpad = {
                        natural_scroll = true;
                    };
                };
            };
            curve = [{
                _args = [
                    "myBezier"
                    {
                        type = "bezier";
                        points = lua "{ {0.05, 0.9}, {0.1, 1.05} }";
                    }
                ];
            }];
            animation = [
                { leaf = "windows"; enabled = true; speed = 7; bezier = "myBezier"; }
                { leaf = "windowsOut"; enabled = true; speed = 7; bezier = "default"; style = "popin 80%"; }
                { leaf = "border"; enabled = true; speed = 10; bezier = "default"; }
                { leaf = "borderangle"; enabled = true; speed = 8; bezier = "default"; }
                { leaf = "fade"; enabled = true; speed = 7; bezier = "default"; }
                { leaf = "workspaces"; enabled = true; speed = 6; bezier = "default"; }
            ];
            window_rule = [
                { match = { class = "^(vesktop)$"; };  opacity = "0.85 0.85"; }
                { match = { class = "^(firefox)$"; };  opacity = "0.95 0.95"; }
                { match = { class = "^(tidal-hifi)$"; };  opacity = "0.75 0.75"; }
                { match = { class = "^(bitwarden-desktop)$"; };  opacity = "0.85 0.85"; }
            ];

            on = {
                _args = [
                    "hyprland.start"
                    (lua ''
                        function()
                            hl.exec_cmd("waybar")
                            hl.exec_cmd("${startupScript}/bin/start")
                        end'')
                ];
            };

            bind = [
                (bind "SUPER + Q" (dsp.exec "kitty"))
                (bind "SUPER + E" (dsp.exec "kitty yazi"))
                (bind "SUPER + SPACE" (dsp.exec "walker"))
                (bind "SUPER + M" (dsp.exec "kitty nvim ~/Cortex/00_NOTES/temp.md"))

                (bind "SUPER + C" dsp.close)
                (bind "SUPER + L" (dsp.exec "hyprlock"))
                (bind "SUPER + V" dsp.float)
                (bind "SUPER + F" dsp.fullscreen)
                (bind "SUPER + J" (dsp.layout "togglesplit"))

                (bind "SUPER + left" (dsp.focus "left"))
                (bind "SUPER + right" (dsp.focus "right"))
                (bind "SUPER + up" (dsp.focus "up"))
                (bind "SUPER + down" (dsp.focus "down"))

                (bind "SUPER + SHIFT + left" (dsp.swap "left"))
                (bind "SUPER + SHIFT + right" (dsp.swap "right"))
                (bind "SUPER + SHIFT + up" (dsp.swap "up"))
                (bind "SUPER + SHIFT + down" (dsp.swap "down"))

                (bind "SUPER + P" (dsp.exec "hyprshot -z -m region -o ~/Pictures/screenshots/"))
                (bind "SUPER + SHIFT + P" (dsp.exec "hyprshot hyprshot --clipboard-only -z -m region"))
                (bind "Print" (dsp.exec "hyprshot -z -m region -o ~/Pictures/screenshots/"))
                    # Special workspace
             #   (bind "SUPER + S" (dsp.toggleSpecial "magic"))
             #   (bind "SUPER + SHIFT + S" (dsp.moveToSpecial "magic"))

                (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
                (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))

                (bindOpts "XF86AudioRaiseVolume" (dsp.exec "swayosd-client --output-volume raise") { locked = true; repeating = true; })
                (bindOpts "XF86AudioLowerVolume" (dsp.exec "swayosd-client --output-volume lower") { locked = true; repeating = true; })
                (bindOpts "XF86AudioMute" (dsp.exec "swayosd-client --output-volume mute-toggle") { locked = true; })
                (bindOpts "XF86AudioMicMute" (dsp.exec "swayosd-client --input-volume mute-toggle") { locked = true; })

                (bindOpts "XF86MonBrightnessUp" (dsp.exec "swayosd-client --brightness raise") { locked = true; repeating = true; })
                (bindOpts "XF86MonBrightnessDown" (dsp.exec "swayosd-client --brightness lower") { locked = true; repeating = true; })

                (bindOpts "SUPER + mouse:272" dsp.drag { mouse = true; })
                (bindOpts "SUPER + mouse:273" dsp.resize { mouse = true; })
            ] ++ workspaceBinds;
        };
    };


    services.udiskie = {
        enable = true;
        tray = "auto"; # Shows a tray icon in Waybar if nm-applet is running
    };

    services.swayosd.enable = true;
}

