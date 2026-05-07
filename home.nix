{ config, lib, pkgs, ... }:
{
    imports = [
        ./nvim.nix
    ];
    home.username = "max";
    home.homeDirectory = "/home/max";
    home.stateVersion = "25.11";
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
    #D 
        (discord.override { withOpenASAR = false; }) # only the icon
    #E
    #F 
#       fastfetch
    #G 
        gdb
        ghidra
        gnome-calculator
    #H   
        htop
        hunspell # libre office- spellchecker
    #    hyprland
        hyprshot
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
        poetry
        pwntools
    #Q
    #R
    #S  
        sl
        swayosd # on screen display for sound and light change
    #T 
        texlab
        texliveFull
        tidal-hifi
    #U
        unzip
    #V  
        vesktop # stylable discord client
    #W
        wireshark
        wttrbar # weather for waybar
    #X
    #Y  
    #Z
        zathura
    ];

    stylix.targets = {
        vesktop.enable = true;
        firefox.enable = true;
        hyprland.enable = true;
#        walker.enable = true;
        wofi.enable = true;
#        bitwarden-desktop.enable = true;
        
        waybar.enable = false;
        hyprlock.enable = false;
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

    programs.librewolf = {
        enable = true;
        #settings = {
            
        

        #};
    };
    programs.wofi = {
        enable = true;
#        style = ''
#            #img {
#                -gtk-icon-effect: dim;
#            }
#        '';
    };
#    services.walker.enable = true; 
#    programs.walker = {    
#        enable = true;
#    };
 
  # --- KITTY CONFIGURATION ---
    programs.kitty = {
        enable = true;
        settings = {
            background_blur = 20;
            remember_window_size = "no";
            initial_window_width = "128c";
            initial_window_height = "40c";
            confirm_os_window_close = -1;
            tab_bar_style = "powerline";
            tab_powerline_style = "round";
        };
        shellIntegration.enableBashIntegration = true;
        
        keybindings = {
            "alt+shift+1" = "goto_tab 1";
            "alt+shift+2" = "goto_tab 2";
            "alt+shift+3" = "goto_tab 3";
            "alt+shift+4" = "goto_tab 4";
            "alt+shift+5" = "goto_tab 5";
            "alt+shift+6" = "goto_tab 6";
            "alt+shift+7" = "goto_tab 7";
            "alt+shift+8" = "goto_tab 8";
            "alt+shift+9" = "goto_tab 9";
            "alt+shift+0" = "goto_tab 10";
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            cursor = {
                no_hardware_cursors = true;
            };
            input = {
            kb_layout = "at";
            kb_variant = "nodeadkeys";
            "touchpad:natural_scroll" = true;
            };
            misc = {
                force_default_wallpaper = 0; # Set to 0 to disable the anime girl/logo
                disable_hyprland_logo = true;
            };
            windowrulev2 = [
                "opacity 0.85 0.85,class:^(vesktop)$"
#                "opacity 0.85 0.85,class:^(bitwarden-desktop)$"

                "opacity 0.95 0.95,class:^(firefox)$"
            ];
            exec-once = [
                "hyprlock"
                "swaybg -i ${config.stylix.image} -m fill"
                "waybar"
                "nm-applet --indicator"
                "udiskie &"
                "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
            ];
            env = [
#                "XCURSOR_SIZE,24"
#                "HYPRCURSOR_SIZE,24"
#                "HYPRCURSOR_THEME,Bibata-Modern-Ice"
            ];
            monitor = ",preferred,auto,1";
            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 2;
                "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base0D}) rgb(${config.lib.stylix.colors.base0E}) 45deg";
                "col.inactive_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base01})";
                layout = "dwindle";
                resize_on_border = true;
                extend_border_grab_area = 20;
            };
            decoration = {
                rounding = 10;
                blur = {
                    enabled = true;
                    size = 3;
                };
            };
            bindm = [
                # Mouse movements: SUPER + Left Click to move, SUPER + Right Click to resize
                "SUPER, mouse:272, movewindow"
                "SUPER, mouse:273, resizewindow"
            ];
            bindr = [
#                "SUPER, SUPER_L, exec, pkill walker || walker"
                "SUPER, SUPER_L, exec, pkill wofi || wofi --show drun --allow-images --prompt 'Search...'"
                #", XF86Calculator, exec, pkill -f gnome-calculator || gnome-calculator -m programming &"
                ", XF86Calculator, exec, gnome-calculator --mode=programming"
#                ", XKB_KEY_F10, exec, wlogout"
            ];
            # Keybindings (Super/Windows key is 'Mod4')
            binde = [
                # Volume with OSD
                ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
                ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
                  
                # Brightness with OSD
                ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
                ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
            ];
            bind = [
                "SUPER, Q, exec, kitty"
                "SUPER, C, killactive,"
                "SUPER, M, exit,"
                "SUPER, E, exec, kitty yazi"
                "SUPER, V, togglefloating,"
                "SUPER, L, exec, hyprlock"

                "SUPER, P, exec, hyprshot -z -m region -o ~/Pictures/screenshots/"
                "SUPER SHIFT, P, exec, hyprshot --clipboard-only -z -m region"
                ", Print, exec, hyprshot -m window -m active -o ~/Pictures/screenshots"
                  
                "SUPER, left, movefocus, l"
                "SUPER, right, movefocus, r"
                "SUPER, up, movefocus, u"
                "SUPER, down, movefocus, d"

                "SUPER, Tab, workspace, e+1"
                "SUPER SHIFT, Tab, workspace, e-1"

                "SUPER SHIFT, 1, movetoworkspace, 1"
                "SUPER SHIFT, 2, movetoworkspace, 2"
                "SUPER SHIFT, 3, movetoworkspace, 3"
                "SUPER SHIFT, 4, movetoworkspace, 4"
                "SUPER SHIFT, 5, movetoworkspace, 5"
                "SUPER SHIFT, 6, movetoworkspace, 6"
                "SUPER SHIFT, 7, movetoworkspace, 7"
                "SUPER SHIFT, 8, movetoworkspace, 8"
                "SUPER SHIFT, 9, movetoworkspace, 9"
                "SUPER SHIFT, 0, movetoworkspace, 10"

                "SUPER, 1, workspace, 1"
                "SUPER, 2, workspace, 2"
                "SUPER, 3, workspace, 3"
                "SUPER, 4, workspace, 4"
                "SUPER, 5, workspace, 5"
                "SUPER, 6, workspace, 6"
                "SUPER, 7, workspace, 7"
                "SUPER, 8, workspace, 8"
                "SUPER, 9, workspace, 9"
                "SUPER, 0, workspace, 10"

                # Mute with OSD
                ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
                # ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ];
            animations = {
                enabled = true;
                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                animation = [
                    "windows, 1, 10, myBezier"
                    "windowsOut, 1, 10, default, popin 80%"
                    "border, 1, 10, default"
                    "fade, 1, 10, default"
                    "workspaces, 1, 10, default" # This controls the "Tab" speed between workspaces
                ];
            };
        };
    };


    services.udiskie = {
        enable = true;
        tray = "auto"; # Shows a tray icon in Waybar if nm-applet is running
    };

    services.swayosd.enable = true;

    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 30;
                modules-left = [ "hyprland/workspaces" ];
                modules-center = ["custom/center-left" "clock" "custom/weather" "custom/center-right"];
                #modules-center = [ "hyprland/window" "clock"];
                modules-right = [ "cpu" "memory" "network" "battery" "bluetooth" "tray" "custom/power"];
                clock = {
                    format = "{:%H:%M}  ";
                    format-alt = "{:%A, %B %d, %Y (%R)}  ";
                    tooltip-format = "<tt><small>{calendar}</small></tt>";
                    calendar = {
                        mode          = "year";
                        mode-mon-col  = 3;
                        weeks-pos     = "right";
                        on-scroll     = 1;
                        on-click-right= "mode";
                        format = {
                            months =     "<span color='${config.lib.stylix.colors.withHashtag.base0E}'><b>{}</b></span>";
                            days =       "<span color='${config.lib.stylix.colors.withHashtag.base04}'><b>{}</b></span>";
                            weeks =      "<span color='${config.lib.stylix.colors.withHashtag.base09}'><b>W{}</b></span>";
                            weekdays =   "<span color='${config.lib.stylix.colors.withHashtag.base0C}'><b>{}</b></span>";
                            today =      "<span color='${config.lib.stylix.colors.withHashtag.base0B}'><b><u>{}</u></b></span>";
                        };
                    };
                };
                tray = {
                    spacing = 10;
                };
                cpu = {
                    format = "  {usage}%"; 
                    tooltip = false;
                };
                memory = {
                    interval = 1;
                    format = "  {used:0.1f}G/{total:0.1f}G";
                    tooltip = false;
                };
                network = {
                    format-wifi = "  {essid}";
                    format-ethernet = "󰈀  {ifname}";
                    format-disconnected = "󰖪  Disconnected";
                    tooltip-format = "{ifname} via {gwaddr}";
                };
                battery = {
                    states = {
                        warning = 30;
                        critical = 15;
                    };
                    format = "{icon} {capacity}%";
                    format-icons = ["" "" "" "" ""];
                };
                bluetooth = {
                    format =  " {status}";
                    format-connected = " {device_alias}";
                    format-connected-battery = " {device_alias} {device_battery_percentage}%";
                    on-click = "blueman-manager";
                };

                "custom/power" = {
                    format = "⏻ ";
                    on-click = "wlogout"; # You'll need to add 'wlogout' to your packages
                    tooltip = false;
                };
                "custom/weather": {
                    format= "{}°";
                    tooltip= true;
                    interval= 3600;
                    exec= ''wttrbar --location London --custom-indicator "{ICON} {FeelsLikeC} ({areaName})"'';
                    return-type= "json";
                };
                "custom/center-left" = {
                    format = " ";
                    tooltip = false;
                };
                "custom/center-right" = {
                    format = " ";
                    tooltip = false;
                };
            };
        };
        style = ''
            * {
                border: none;
                border-radius: 10px;
                margin: 0 2px;
                padding: 0 2px;
            }
            window#waybar {
                background: transparent;
            }
            .modules-right :nth-child(odd) .module{
                 background-image: linear-gradient(to left, ${config.lib.stylix.colors.withHashtag.base01},${config.lib.stylix.colors.withHashtag.base03});
            }
            .modules-right :nth-child(even) .module{
                 background-image: linear-gradient(to right, ${config.lib.stylix.colors.withHashtag.base01},${config.lib.stylix.colors.withHashtag.base03});
            }
            #workspaces button:nth-child(even){
                background-color: ${config.lib.stylix.colors.withHashtag.base02};
                border-bottom-color: ${config.lib.stylix.colors.withHashtag.base0C};
            }
            #workspaces button:nth-child(odd){
                background-color: ${config.lib.stylix.colors.withHashtag.base01};
                border-bottom-color: ${config.lib.stylix.colors.withHashtag.base08};
            }
            #workspaces button.active{
                /* 
                background-color: ${config.lib.stylix.colors.withHashtag.base08};
                border-bottom-color: ${config.lib.stylix.colors.withHashtag.base08};
                margin-top: 2px;
                */
                border-bottom-style: solid;
                border-bottom-width: 5px;
            }
            .modules-center *{
                margin: 0;
            }
            #clock{
                background-color: ${config.lib.stylix.colors.withHashtag.base02};
                border-radius: 0 0 10px 10px;
            }
            #custom-center-right,
            #custom-center-left{
                min-width:10px;
                background-color:${config.lib.stylix.colors.withHashtag.base0B}
            }
        ''; 
    };
    programs.wlogout = {
        enable = true;
        layout = [
            {
                label = "lock";
                action = "hyprlock";
                text = "(L)ock";
                keybind = "l";
            #    height = 1;
            #    width = 1;
            #    circular = true;
            }
            {
                label = "shutdown";
                action = "systemctl poweroff";
                text = "Shutdow(n)";
                keybind = "n";
            #    height = 1;
            #    width = 1;
            #    circular = true;
            }
            {
                label = "reboot";
                action = "systemctl reboot";
                text = "(R)eboot";
                keybind = "r";
            }
        ];
        style = ''
            window {
            /*
                background-color: ${config.lib.stylix.colors.withHashtag.base00};
                opacity: 10%;
            */ 
                background-color: rgba(0,0,0,0.5);
            }
            button {
                background-color: ${config.lib.stylix.colors.withHashtag.base02};
                color: ${config.lib.stylix.colors.withHashtag.base09};
                transition: box-shadow 0.7s ease-in-out, background-color 0.7s ease-in-out;
            /*
                margin: 0, 10%;
            */
            }
            button:hover{
                background-color: ${config.lib.stylix.colors.withHashtag.base03};
            }
        '';
    };



    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                disable_loading = true;
                grace = 0;
                hide_cursor = true;
            };

            background = [
                {
                    path = "screenshot"; # This takes a blurred screenshot of your current screen
                    blur_passes = 3;
                    blur_size = 8;
                }
            ];

            input-field = [
                {
                    size = "200, 50";
                    position = "0, -20";
                    monitor = "";
                    dots_center = true;
                    fade_on_empty = false;
                    font_color = "rgb(202, 211, 245)";
                    inner_color = "rgb(91, 96, 120)";
                    outer_color = "rgb(24, 25, 38)";
                    outline_thickness = 5;
                    placeholder_text = "Password...";
                    shadow_passes = 2;
                }
            ];
            label = [
                {
                    monitor = "";
                    # This command tells hyprlock to display the time in 24h format
                    text = "$TIME"; 
                    color = "rgba(242, 243, 244, 0.75)";
                    font_size = 95;
                    font_family = "JetBrains Mono Nerd Font Bold"; # Or your favorite font
                    position = "0, 300";
                    halign = "center";
                    valign = "center";
                }
                {
                    monitor = "";
                    # This displays the date below the time
                    text = "cmd[update:1000] echo \"$(date +'%A, %d %B')\"";
                    color = "rgba(242, 243, 244, 0.75)";
                    font_size = 22;
                    font_family = "JetBrains Mono Nerd Font";
                    position = "0, 200";
                    halign = "center";
                    valign = "center";
                }
            ];
        };
    };


    # --- BASH CONFIGURATION ---
    programs.bash = {
        enable = true;
        shellAliases = {
            ll = "ls -la";
            nv = "nvim";
            sudo = "sudo ";
             # nos = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos -L";
            nos = ''git -C ~/dotfiles add . && git -C ~/dotfiles commit -m "update: $(date)" || true && nh os switch ~/dotfiles && git -C ~/dotfiles push'';
            nix-update = ''cd ~/dotfiles && nix flake update && nos && nix-collect-garbage''; 
        };
        
        bashrcExtra = ''
          function y() {
              local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
              command yazi "$@" --cwd-file="$tmp"
              IFS= read -r -d ''' cwd < "$tmp"
              [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
              rm -f -- "$tmp"
          }
        '';

        # Fastfetch on startup
        initExtra = ''
          fastfetch
        '';
    };
    
    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                padding.left = 2;
            };
            modules = [
                "title"
                "separator"
                "os"
                "host"
                "kernel"
                "uptime"
                "packages"
                "shell"
                "display"
                "terminal"
                "terminalfont"
                "cpu"
                "gpu"
                "memory"
                "swap"
                "disk"
                "battery"
                "poweradapter"
                "locale"                
            ];
        };
    };

    programs.yazi = {
        enable = true;
        settings = {
            
            opener = {
                pdf-viewer = [
                    { run = ''zathura "$@"'';orphan = true; block = false; }
                ];
                text-edit = [
                    { run = ''$EDITOR "$@"''; orphan = true; block = true;}
                ];
                open = [
                    {run = ''xdg-open "$@"''; orphan = true;}
                ];
            };
            open = {
                rules = [
                    { mime = "application/pdf"; use = "pdf-viewer"; }
                    { mime = "text/*"; use = "text-edit";}
                    { name = "*.html"; use = ["open" "text-edit"];}

                ];
                append_rules = [
	                { name = "*"; use = "open"; }# fallback
                ];
            };
        };
        keymap = {
            mgr.prepend_keymap = [
                {
                on = [ "g" "m" ];
                run = "cd /run/media/max/";
                desc = "Go to Media";
                }
            ];
        };
        #theme = {
        #    indicator = {
        #        current = {underline =true; fg= "${config.lib.stylix.colors.withHashtag.base0C}";};
        #    };
        #};
    };
}

