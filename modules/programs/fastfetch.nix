{config, inputs, pkgs,  ...}:
let 
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
#    stylix.targets.enable = true;

    programs.fastfetch = {
        enable = true;
        package = unstable.fastfetch;
        settings = {
            logo = {
                color = {
                    "1"= "${config.lib.stylix.colors.withHashtag.base0A}";
                    "2"= "${config.lib.stylix.colors.withHashtag.base0B}";
                    "3"= "${config.lib.stylix.colors.withHashtag.base0C}";
                    "4"= "${config.lib.stylix.colors.withHashtag.base0D}";
                    "5"= "${config.lib.stylix.colors.withHashtag.base0E}";
                    "6"= "${config.lib.stylix.colors.withHashtag.base0F}";
                };
                source = "nixos";
                padding.left = 2;
            };
            modules = [
                "title"
                "separator"
                "os"
                "host"
                "kernel"
                "uptime"
#                "packages"
                "shell"
                "display"
                "terminal"
                "terminalfont"
                "cpu"
          #      "gpu"
                "memory"
          #      "swap"
          #      "disk"
                "battery"
                "poweradapter"
                "locale"
                "colors"
            ];
        };
    };
}
