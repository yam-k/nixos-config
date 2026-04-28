{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs = inputs:
    let
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
      {
        nixosConfigurations = {
          "kobako" = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit pkgs-unstable;
            };
            modules = [
              ./modules/hardware-configuration.nix

              ./modules/system.nix
              ./modules/devices.nix
              ./modules/l10n.nix
              ./modules/gui.nix
              ./modules/packages.nix
              ./modules/users.nix
            ];
          };
        };
      };
}
