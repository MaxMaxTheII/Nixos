{...}:
{
    programs.bash = {
        enable = true;
        shellAliases = {
            ll = "ls -la";
            nv = "nvim";
            sudo = "sudo ";
             # nos = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos -L";
            nos = ''git -C ~/dotfiles add . && git -C ~/dotfiles commit -m "update: $(date)" || true && nh os switch ~/dotfiles && git -C ~/dotfiles push'';
            nix-update = ''cd ~/dotfiles && nix flake update && nos && nix-collect-garbage''; 
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
            if (( $(tput cols) >= 110 )); then
                fastfetch
            else
                fastfetch --logo nixos_small
            fi
        '';
    };
}    
