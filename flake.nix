{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = inputs: {
    nixosConfigurations = {
      "kobako" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}

