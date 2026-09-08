{config, ...}:
{
    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 30;
                modules-left = [ "hyprland/workspaces" "custom/music"];
                modules-center = ["clock" "custom/weather"];
                modules-right = [ "cpu" "memory" "network" "battery" "bluetooth" "tray" "custom/power"];
                clock = {
                    format = "{:%H:%M}  ";
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
                    on-click = "walker -m bluetooth";
                };
                "hyprland/workspaces" = {
                    format = "{icon}";
                    format-icons = {
                        "1"="I"; 
                        "2"="II"; 
                        "3"="III"; 
                        "4"="IV"; 
                        "5"="V"; 
                        "6"="VI"; 
                        "7"="VII"; 
                        "8"="VIII"; 
                        "9"="IX"; 
                        "10"="X";
                    };
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
                    exec= ''wttrbar --location Graz --custom-indicator "{ICON} {FeelsLikeC}"'';
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
                border-radius: 0;
                background: rgba(0,0,0,0.4);
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
            #workspaces{
                margin: 0 2px 0 0;
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
}
