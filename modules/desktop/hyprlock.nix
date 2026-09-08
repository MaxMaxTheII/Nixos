{    
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
}
