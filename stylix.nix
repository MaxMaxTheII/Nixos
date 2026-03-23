{ pkgs, ... }: {
    stylix = {
        enable = true;
        image = ./data/wallpapers/zergling-wp.png;
        # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";# TODO remove
        base16Scheme = lib.attrsets.recursiveUpdate 
            (config.lib.stylix.scheme "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml")
            {
            base00 = "18111b"; # A very deep purple-black (Darker than Mocha)
            base03 = "8c6c8c"; # Brighter pinkish-gray for Line Numbers/Comments
            base04 = "b48ead"; # Subtle Muted Pink for secondary UI
            base05 = "f5e0dc"; # Soft Rose-White for main text
            base0D = "f5c2e7"; # The "Zergling Pink" for active window borders/highlights
            base0E = "cba6f7"; # Soft Purple for keywords
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
