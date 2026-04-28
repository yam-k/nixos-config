{ pkgs, ... }:
{
  # Users
  users.users = {
    "kei" = {
      isNormalUser = true;
      description = "YAMAMOTO Kei";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = (with pkgs; [
        stow
        wget
        curl
        unzip
        pandoc
        texliveFull
        vivaldi
        calibre
        kdePackages.okular
        kdePackages.audex
        flac
        kdePackages.elisa
        kdePackages.k3b
        libdvdcss
        vlc
      ]);
    };
  };
}
