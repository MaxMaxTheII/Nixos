{pkgs, config, ...}:
let
    quickshellConfig = "${config.home.homeDirectory}/dotfiles/config/quickshell";
in 
{
    home.packages = with pkgs; [
        quickshell
        jq #json parser
    ];
    xdg.configFile."quickshell" = {
        source = config.lib.file.mkOutOfStoreSymlink quickshellConfig;
    };
}
