{ ... }: 
{ 
    programs.yazi = { 
        enable = true;

        settings = { 
            opener = { 
                pdf-viewer = [ { run = ''zathura "$@"''; orphan = true; } ];
                text-edit = [ { run = ''nvim "$@"''; block = true; } ];
                open = [ { run = ''xdg-open "$@"''; orphan = true; } ]; 
            };
            open.rules = [ 
            # PDFs -> Zathura 
                { mime = "application/pdf"; use = "pdf-viewer"; }
            # HTML -> browser by default, Neovim as alternative 
                { url = ".html"; use = [ "open" "text-edit" ]; } { url = ".htm"; use = [ "open" "text-edit" ]; }
            # Source files -> Neovim 
                { url = ".lua"; use = "text-edit"; }
                { url = ".tex"; use = "text-edit"; }
                { url = ".bib"; use = "text-edit"; }
                { url = ".md"; use = "text-edit"; }
                { url = ".nix"; use = "text-edit"; }
                { url = ".py"; use = "text-edit"; }
                { url = ".rs"; use = "text-edit"; }
                { url = ".c"; use = "text-edit"; }
                { url = ".h"; use = "text-edit"; }
                { url = ".lock"; use = "text-edit"; }
                { url = ".cpp"; use = "text-edit"; }
                { url = "*.sh"; use = "text-edit"; }
            # Other text files -> Neovim 
                { mime = "text/*"; use = "text-edit"; }
            # Everything else -> default application 
                { url = "*"; use = "open"; } 
            ]; 
        };
        keymap.mgr.prepend_keymap = [ 
            { 
                on = [ "g" "m" ]; 
                run = "cd /run/media/max/"; 
                desc = "Go to Media"; 
            } 
        ]; 
    }; 
}
