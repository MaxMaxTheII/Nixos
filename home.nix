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
        hyprlock
        swaybg -i ${config.stylix.image} -m fill
        nm-applet --indicator 
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
        inputs.walker.homeManagerModules.default
    ];
    home.username = "max";
    home.homeDirectory = "/home/max";
    home.stateVersion = "26.05";
    home.sessionVariables = {
        EDITOR = "nvim";
#        LOCATION = "London";
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
        zip
    ];

    stylix.targets = {
        vesktop.enable = true;
        firefox.enable = true;
        hyprland.enable = true;
#        tidal-hifi.enable = true;
#        walker.enable = true;
        wofi.enable = true;
#        bitwarden-desktop.enable = true;
        
        waybar.enable = true;
        librewolf.enable = false;
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

    programs.librewolf = {
        enable = true;
        #settings = {
            
        

        #};
    };
#    programs.wofi = {
#        enable = true;
#        style = ''
#            #img {
#                -gtk-icon-effect: dim;
#            }
#        '';
#    };
    programs.cava = {
        enable = true;
#        settings = {
#            color = {
#                background = "'#000000'";
#                foreground = "'#00FFFF'";
#            };
#        };
    };
#    services.walker.enable = true; 
    programs.walker = {    
        enable = true;
        #package = unstable.walker;
        runAsService = true;
    };
 
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
                    gaps_in = 2;
                    gaps_out = 5;
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
#                    follow_mouse = 0;
#                    sensitivity = -0.2;
                    natural_scroll = false;
                    touchpad = {
                        natural_scroll = true;
                    };
                };
            };
#            windowrulev2 = [
#                "opacity 0.85 0.85,class:^(vesktop)$"
#                "opacity 0.85 0.85,class:^(bitwarden-desktop)$"
#
#                "opacity 0.95 0.95,class:^(firefox)$"
#               ];
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
                # App launchers
                (bind "SUPER + Q" (dsp.exec "kitty"))
                (bind "SUPER + E" (dsp.exec "kitty yazi"))
                (bind "SUPER + SPACE" (dsp.exec "walker"))
               # (bind "SUPER + CTRL + V" (dsp.exec "walker -m clipboard"))
                (bind "SUPER + M" (dsp.exec "kitty nvim ~/Cortex/00_NOTES/temp.md"))

                    # Screenshots
              #  (bind "SUPER + CTRL + 4" (dsp.exec "grimblast copysave area"))
              #  (bind "SUPER + CTRL + 5" (dsp.exec "grimblast copysave screen"))

                    # Universal copy/paste
                #(bind "SUPER + C" (dsp.sendshortcut "CTRL" "Insert"))
                #(bind "SUPER + V" (dsp.sendshortcut "SHIFT" "Insert"))
                #(bind "SUPER + X" (dsp.sendshortcut "CTRL" "X"))

                    # Window management
                (bind "SUPER + C" dsp.close)
                (bind "SUPER + SHIFT + Q" dsp.exit)
                (bind "SUPER + L" (dsp.exec "hyprlock"))
                (bind "SUPER + V" dsp.float)
                (bind "SUPER + F" dsp.fullscreen)
                (bind "SUPER + P" dsp.pseudo)
                (bind "SUPER + J" (dsp.layout "togglesplit"))

                    # Focus
                (bind "SUPER + left" (dsp.focus "left"))
                (bind "SUPER + right" (dsp.focus "right"))
                (bind "SUPER + up" (dsp.focus "up"))
                (bind "SUPER + down" (dsp.focus "down"))

                    # Swap windows
                (bind "SUPER + SHIFT + left" (dsp.swap "left"))
                (bind "SUPER + SHIFT + right" (dsp.swap "right"))
                (bind "SUPER + SHIFT + up" (dsp.swap "up"))
                (bind "SUPER + SHIFT + down" (dsp.swap "down"))

#                "SUPER, P, exec, hyprshot -z -m region -o ~/Pictures/screenshots/"
#                "SUPER SHIFT, P, exec, hyprshot --clipboard-only -z -m region"
#                ", Print, exec, hyprshot -m window -m active -o ~/Pictures/screenshots"

                    # Special workspace
             #   (bind "SUPER + S" (dsp.toggleSpecial "magic"))
             #   (bind "SUPER + SHIFT + S" (dsp.moveToSpecial "magic"))

                    # Scroll through workspaces
                (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
                (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))

                    # Volume keys
                (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume @ 5%+") { locked = true; repeating = true; })
                (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @ 5%-") { locked = true; repeating = true; })
                (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @ toggle") { locked = true; })
                (bindOpts "XF86AudioMicMute" (dsp.exec "wpctl set-mute u/DEFAULT_AUDIO_SOURCE@ toggle") { locked = true; })

                    # Mouse move/resize
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

    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 30;
                modules-left = [ "hyprland/workspaces" "custom/music"];
                modules-center = ["custom/center-left" "clock" "custom/weather" "custom/center-right"];
                #modules-center = [ "hyprland/window" "clock"];
                modules-right = [ "cpu" "memory" "network" "battery" "bluetooth" "tray" "custom/power"];
                clock = {
                    format = "{:%H:%M}  ";
                    # format-alt = "{:%A, %B %d, %Y (%R)}  ";
                    format-alt = "{:%A, %B %d, %Y (%R)}";
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
                    tooltip = true;
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
                "custom/music" = {
                    format = "{}";
                    interval = 1;
                    # max-length = 40;
                    exec = ''
                        if ! playerctl status >/dev/null 2>&1; then
                            exit 0
                        fi
                        TITLE="$(playerctl metadata title 2>/dev/null || echo 'No Media')"
                        ARTIST="$(playerctl metadata artist 2>/dev/null || echo 'Unknown')"
                        POS=$(playerctl position 2>/dev/null || echo 0)
                        LEN=$(playerctl metadata mpris:length 2>/dev/null || echo 1)
                        awk -S -v t="$TITLE" -v a="$ARTIST" -v p="$POS" -v l="$LEN" 'BEGIN {
                            pct=int((p / (l / 1000000)) * 100);
                            txt=t " | " a;
                            if (length(txt) > 40) txt=substr(txt, 1, 37) "...";
                            gsub(/"/, "\\\"", t);
                            gsub(/"/, "\\\"", a);
                            gsub(/"/, "\\\"", txt);
                            total_len = length(txt);
                            split_idx = int((pct / 100) * total_len);
                            played = substr(txt, 1, split_idx);
                            remaining = substr(txt, split_idx + 1);
                            ul_color = "#a6e3a1";
                            marked_text = "<span underline=\\\"double\\\" underline_color=\\\"" ul_color "\\\">" played "</span>" remaining;
                            tt = t "\\n" a "\\n" pct "%";
                            print "{\"text\": \"" marked_text "\", \"percentage\": " pct ", \"tooltip\": \"" tt "\"}"
                        }'
                    '';
                    on-click = "playerctl play-pause";
                    return-type = "json";
                    tooltip = true;
                }; 
                "custom/power" = {
                    format = "⏻ ";
                    on-click = "wlogout"; # You'll need to add 'wlogout' to your packages
                    tooltip = false;
                };
                "custom/weather"= {
                    format= "{}°";
                    tooltip= true;
                    interval= 3600;
                    #exec= ''wttrbar --location $LOCATION --custom-indicator "{ICON} {FeelsLikeC}"'';
                    exec= ''wttrbar --location Graz --custom-indicator "{ICON} {FeelsLikeC}"'';
#                    on-click = ''export LOCATION="$(./city.sh)"'';
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
                /*
                font-family: "JetBrainsMono Nerd Font", sans-serif;
                */
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
            #workspaces button.visible{
                border-bottom-style: dotted;
                border-bottom-width: 5px;
            }
            #workspaces button.active{
                border-bottom-style: solid;
                border-bottom-width: 5px;
            }
            #workspaces button.urgent{
                background-color: ${config.lib.stylix.colors.withHashtag.base0A};
                color:#000;
            }
            .modules-center *{
                margin: 0;
            }
            #custom-music{
                background-color: ${config.lib.stylix.colors.withHashtag.base02};
                /*underline-color: ${config.lib.stylix.colors.withHashtag.base08};*/
                padding: 0 5px;
                border-radius: 0 0 10px 10px;
            }
            #custom-weather{
                background-color: ${config.lib.stylix.colors.withHashtag.base02};
                border-radius: 0 0 10px 0;
            }
            #clock{
                background-color: ${config.lib.stylix.colors.withHashtag.base02};
                border-radius: 0 0 0 10px;
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
/*          
            button label::first-letter{
                color: ${config.lib.stylix.colors.withHashtag.base0C};
            }
*/
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
        package = unstable.fastfetch;
        settings = {
            logo = {
                color = {
                    "1"= "${config.lib.stylix.colors.withHashtag.base0A}";
                    "2"= "${config.lib.stylix.colors.withHashtag.base0B}";
                    "3"= "${config.lib.stylix.colors.withHashtag.base0C}";
                    "4"= "${config.lib.stylix.colors.withHashtag.base0D}";
                    "5"= "${config.lib.stylix.colors.withHashtag.base0E}";
                    "6"= "${config.lib.stylix.colors.withHashtag.base0F}";
                };
                source = "nixos";
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
          #      "memory"
          #      "swap"
          #      "disk"
                "battery"
                "poweradapter"
                "locale"
                "colors"
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
                    { name = "*.html"; url = "*.html"; use = ["open" "text-edit"];}

                ];
                append_rules = [
	                { name = "*"; use = "open"; url="*"; }# fallback
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

