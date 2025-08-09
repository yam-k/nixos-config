{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "kobako";

  # Enable networking
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Asia/Tokyo";

  # Internationalisation
  i18n.defaultLocale = "ja_JP.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Desktop Environments
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  # Input Method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      plasma6Support = true;
      addons = with pkgs; [ fcitx5-skk ];
      settings = {
        globalOptions = {
          "Hotkey" = {
            # "TriggerKeys" = "Zenkaku_Hankaku";
            "AltTriggerKeys" = "";
            "EnumerateForwardKeys" = "";
            "EnumerateBackwardKeys" = "";
            "EnumerateGroupForwardKeys" = "";
            "EnumerateGroupBackwardKeys" = "";
          };
          "Hotkey/ActivateKeys"."0" = "Henkan";
          "Hotkey/DeactivateKeys"."0" = "Muhenkan";
          "Behavior"."showInputMethodInformationWhenFocusIn" = "True";
        };
        inputMethod = {
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "jp";
            "DefaultIM" = "skk";
          };
          "Groups/0/Items/0"."Name" = "keyboard-jp";
          "Groups/0/Items/1"."Name" = "skk";
          "GroupOrder"."0" = "Default";
        };
      };
    };
  };
  services.xserver.exportConfiguration = true;

  # CUPS
  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account
  users.users.kei = {
    isNormalUser = true;
    description = "YAMAMOTO Kei";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    xdg-user-dirs
    home-manager
    git
    tree
    wget
    curl
    pandoc
    texliveFull
    roswell
    rustup
    python3Full
    wofi
    kdePackages.konsole
    google-chrome
    nyxt
    dropbox-cli
    calibre
    soundkonverter
    flac
    kdePackages.kasts
    kdePackages.k3b
    vlc
    libdvdcss
    virt-manager
  ];

  # GNU Emacs
  services.emacs = {
    install = true;
    defaultEditor = true;
    package = pkgs.emacs-pgtk;
  };

  # Firefox
  programs.firefox = {
    enable = true;
    languagePacks = [ "ja" ];
  };

  # Podman
  virtualisation.podman.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    extest.enable = true;
  };

  # NixOS version
  system.stateVersion = "25.05";

}
