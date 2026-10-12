{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = ./../../config/nvim;
    recursive = true;
  };

  home.packages = with pkgs; [
    texlab
    zathura
    ripgrep
    fd
    gcc
    git
    gnumake
  ];
}
