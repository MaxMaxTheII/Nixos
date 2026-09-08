{...}:
{
#    stylix.targets.enable = true;

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
    };
}
