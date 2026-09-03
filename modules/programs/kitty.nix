{    
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
}   
