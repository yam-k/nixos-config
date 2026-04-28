{ inputs, pkgs, lib, ... }:
{
  imports =
    [
      inputs.hyprland.nixosModules.default
    ];

  # Window manager
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      extraConfig = (builtins.readFile ./hyprland.conf);
    };
    uwsm.waylandCompositors.hyprland.binPath =
      lib.mkForce "/run/current-system/sw/bin/start-hyprland";
  };
}
