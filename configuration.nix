{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # NixOS version used for installation
  system.stateVersion = "25.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "kobako";
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  # Sounds
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printer
  services.printing.enable = true;

  # USB
  services.udisks2.enable = true;

  # Time zone
  time.timeZone = "Asia/Tokyo";

  # Internationalisation
  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ja_JP.UTF-8";
      LC_IDENTIFICATION = "ja_JP.UTF-8";
      LC_MEASUREMENT = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
      LC_NAME = "ja_JP.UTF-8";
      LC_NUMERIC = "ja_JP.UTF-8";
      LC_PAPER = "ja_JP.UTF-8";
      LC_TELEPHONE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
    };
  };

  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = [ pkgs.kdePackages.qt5compat ];
    autoNumlock = true;
    theme = "${pkgs.where-is-my-sddm-theme}/share/sddm/themes/where_is_my_sddm_theme";
  };

  # Window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      hackgen-font
      hackgen-nf-font
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK JP" "Noto Color Emoji" ];
        serif = [ "Noto Serif CJK JP" "Noto Color Emoji" ];
        monospace = [ "HackGen Console NF" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # Input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [ fcitx5-skk ];
      waylandFrontend = true;
    };
  };

  # Keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Users
  users.users = {
    "kei" = {
      isNormalUser = true;
      description = "YAMAMOTO Kei";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        git
        stow
        wget
        curl
        unzip
        emacs-pgtk
        pandoc
        texliveFull
        udiskie
        alacritty
        fuzzel
        nyxt
        vivaldi
        calibre
        kdePackages.okular
        kdePackages.audex
        flac
        kdePackages.elisa
        kdePackages.k3b
        libdvdcss
        vlc
      ];
    };
  };

  # Firefox
  programs.firefox = {
    enable = true;
    languagePacks = [ "ja" ];
  };

  # Steam
  programs.steam = {
    enable = true;
    extest.enable = true;
  };
}
