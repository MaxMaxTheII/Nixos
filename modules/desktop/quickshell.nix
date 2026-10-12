{pkgs, ...}:
let
    quickshellConfig = "${config.home.homeDirectory}/dotfiles/config/quickshell";
in 
{
    home.packages = [
        pkgs.quickshell
    ];
    xdg.configFile."quickshell".source = 
        config.lib.file.mkOutOfStoreSymlink quickshellConfig;
}
