{ pkgs, config, lib,  ... }: {
    stylix = {
        enable = true;
        
       

        polarity = "dark";

        image = ./data/wallpapers/zergling-wp.jpg;
        base16Scheme = {
            base00 = "0b0a11"; # very dark background (almost black with purple tint)
            base01 = "14121c"; # subtle elevation
            base02 = "1f1b2e"; # UI panels
            base03 = "6e6a86"; # comments (cool gray-purple)

            base04 = "a8a3c2"; # secondary text
            base05 = "e9e6ff"; # primary text (bright, slightly cool)
            base06 = "f5f3ff"; # brighter foreground
            base07 = "ffffff"; # pure white highlights

            base08 = "ff2e97"; # neon pink
            base09 = "ff9f43"; # neon orange
            base0A = "ffe66d"; # neon yellow
            base0B = "2bff88"; # neon green

            base0C = "00f0ff"; # turquise
            base0D = "9d7bff"; # light purple
            base0E = "d16dff"; # purple-pink
            base0F = "ff6ad5"; # gentel pink
        };
        cursor = {
 	       	package = pkgs.bibata-cursors;
 	       	name = "Bibata-Modern-Classic";
 	       	size = 24;
 	    };
        fonts = {
            monospace = {
                package = pkgs.comic-mono;
                name = "Comic Mono";
            };
            sansSerif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Sans";
            };
            serif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Serif";
            };
            sizes = {
                applications = 12;
                terminal = 12;
            };
        };

        packages = with pkgs; [
            font-awesome
        ];
        opacity = {
            terminal = 0.8;
            applications = 0.8;
            desktop = 0.7;
        };
    };
}
