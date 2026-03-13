{ config, pkgs, ... }:

{
  imports = [
    ./nvim.nix
  ];
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.11";

  # ENV vars
  home.sessionVariables = {
    EDITOR = "nvim";
#    FLAKE = "/home/max/dotfiles";
  };
  # This allows Home Manager to manage itself
  programs.home-manager.enable = true;

  # --- KITTY CONFIGURATION ---
  programs.kitty = {
    enable = true;
    font = {
      name = "Comic Mono";
      size = 11;
    };
    settings = {
      background_opacity = "0.8";
      background_blur = 20;
      remember_window_size = "no";
      initial_window_width = "128c";
      initial_window_height = "40c";
      confirm_os_window_close = -1;
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
    };
    shellIntegration.enableBashIntegration = true;
    
    keybindings = {
      "alt+shift+1" = "goto_tab 1";
      "alt+shift+2" = "goto_tab 2";
      "alt+shift+3" = "goto_tab 3";
      # ... you can add the rest here
    };
  };

# --- BASH CONFIGURATION ---
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      nv = "nvim";
      sudo = "sudo ";
      nos = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos -L";
    };
    
    bashrcExtra = ''
      function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          command yazi "$@" --cwd-file="$tmp"
          IFS= read -r -d ''' cwd < "$tmp"
          [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
          rm -f -- "$tmp"
      }
    '';

    # Fastfetch on startup
    initExtra = ''
      fastfetch
    '';
  };
programs.yazi = {
  enable = true;
  keymap = {
    manager.prepend_keymap = [
      {
        on = [ "g" "m" ];
        run = "cd /run/media/max/";
        desc = "Go to Media";
      }
    ];
  };
};
}
