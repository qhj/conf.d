{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    sops-nix.url = github:Mic92/sops-nix;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, home-manager }:
  let
    inherit (self) outputs;
  in
  {
    nixosConfigurations = {
      ms10 = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          ./nixos/hosts/ms10
          sops-nix.nixosModules.sops
        ];
      };
    };


    homeManagerModules = import ./home-manager/modules;

    homeConfigurations =
    let
      user = "qhj";
    in
    {
      "${user}@ms10" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit user outputs; };
        modules = [
          ./home-manager/hosts/ms10.nix
          ./home-manager/home.nix
        ];
      };
      "${user}@wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit user outputs; };
        modules = [
          ./home-manager/hosts/wsl.nix
          ./home-manager/home.nix
        ];
      };
    };
  };
}
