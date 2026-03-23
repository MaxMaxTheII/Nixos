{ pkgs, ... }: {
    stylix = {
        enable = true;
        image = ./data/wallpapers/zergling-wp.png;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";# TODO remove

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
        };
    };
    fonts.packages = with pkgs; [
        font-awesome
    ];
}
