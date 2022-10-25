{
  description = "A very basic flake";

  inputs = { nixpkgs.url = "nixpkgs/nixos-22.05"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfiguration = {
        raspi = lib.nixos.System {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };

    };
}
