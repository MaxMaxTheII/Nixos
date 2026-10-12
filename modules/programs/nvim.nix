{ config, pkgs, ... }:

{
    stylix.targets.neovim = {
        enable = true;
        plugin = "base16-nvim";
    };

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
    tree-sitter
    zathura
    ripgrep
    fd
    gcc
    git
    gnumake
  ];
}
