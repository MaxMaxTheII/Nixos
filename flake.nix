{
    description = "Max's NixOS Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
        # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        stylix.url = "github:nix-community/stylix/release-25.11";
        elephant.url = "github:abenz1267/elephant";
        walker = {
            url = "github:abenz1267/walker";
            inputs.elephant.follows = "elephant";
        }; 
    # Add Home Manager input
        home-manager = {
            #url = "github:nix-community/home-manager/release-26.05";
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
                stylix.nixosModules.stylix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                    home-manager.users.max = {
                        imports  = [
                            ./home.nix
                        ];
                    };
                }
            ];
        };
    };
}
