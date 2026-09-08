{config,  ...}:
{
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
                action = "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff'";
                text = "Shutdow(n)";
                keybind = "n";
            #    height = 1;
            #    width = 1;
            #    circular = true;
            }
            {
                label = "reboot";
                action = "hyprshutdown -t 'Rebooting...' --post-cmd 'systemctl reboot'";
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
}
