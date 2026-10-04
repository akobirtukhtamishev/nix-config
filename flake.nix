{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-snapd, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        nix-snapd.nixosModules.default

        {
   	   services.asusd.package =
      	     nixpkgs-unstable.legacyPackages.x86_64-linux.asusctl;

          environment.systemPackages = [
            nixpkgs-unstable.legacyPackages.x86_64-linux.asusctl
          ];
        }

        {
          services.snap.enable = true;
        }
      ];
    };
  };
}
