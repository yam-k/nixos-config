{ pkgs, pkgs-unstable, ... }:
{
  # System packages
  environment.systemPackages =
    (with pkgs; [
      git
      udiskie
      alacritty
      fuzzel
      nyxt
    ])
    ++
    (with pkgs-unstable; [
      dropbox-cli
    ]);

  # direnv
  programs.direnv.enable = true;

  # GNU Emacs
  services.emacs = {
    install = true;
    defaultEditor = true;
    package = pkgs.emacs-pgtk;
  };

  # Steam
  programs.steam = {
    enable = true;
    extest.enable = true;
  };
}
