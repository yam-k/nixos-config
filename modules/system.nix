{
  # NixOS version used for installation
  system.stateVersion = "25.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
