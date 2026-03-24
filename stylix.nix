{ pkgs, config, lib,  ... }: {
    stylix = {
        enable = true;
        # image = ./data/wallpapers/zergling-wp.png;
        image = ./data/wallpapers/zergling-wp.jpg;
        targets.hyprland.enable = true;
        # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";# TODO remove
/*        base16Scheme = lib.attrsets.recursiveUpdate 
            (config.lib.stylix.scheme "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml")
            {
            base00 = "18111b"; # A very deep purple-black (Darker than Mocha)
            base03 = "8c6c8c"; # Brighter pinkish-gray for Line Numbers/Comments
            base04 = "b48ead"; # Subtle Muted Pink for secondary UI
            base05 = "f5e0dc"; # Soft Rose-White for main text
            base0D = "f5c2e7"; # The "Zergling Pink" for active window borders/highlights
            base0E = "cba6f7"; # Soft Purple for keywords
            };
            */ 
        base16Scheme = {
            base00 = "18111b"; # Deep dark purple-black background
            base01 = "211924"; # Lighter background (status bars)
            base02 = "3b2d3d"; # Selection background
            base03 = "8c6c8c"; # Line Numbers / Comments (Visible but subtle pink-gray)
            base04 = "b48ead"; # Subtle Muted Pink
            base05 = "f5e0dc"; # Main Text (Soft Rose-White)
            base06 = "f2cdcd"; # Brighter foreground
            base07 = "b4befe"; # Soft lavender
            base08 = "f38ba8"; # Red (Errors)
            base09 = "fab387"; # Orange
            base0A = "f9e2af"; # Yellow
            base0B = "a6e3a1"; # Green
            base0C = "94e2d5"; # Cyan
            base0D = "f5c2e7"; # Zergling Pink (Active Border / Highlights)
            base0E = "cba6f7"; # Soft Purple
            base0F = "f2cdcd"; # Extra pink accent
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

        opacity = {
            terminal = 0.8;
            applications = 0.8;
            desktop = 0.7;
        };
    };
    fonts.packages = with pkgs; [
        font-awesome
    ];
}
