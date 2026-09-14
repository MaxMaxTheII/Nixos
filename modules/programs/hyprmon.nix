{pkgs, inputs, ...}:
let 
    unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in 
{
    home.packages = [
        unstable.hyprmon
    ];
    wayland.windowManager.hyprland.extraConfig = ''
        require("hyprmon")
    '';
}
