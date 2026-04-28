{ inputs, pkgs, lib, ... }:
{
  imports =
    [
      inputs.hyprland.nixosModules.default
    ];

  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = [ pkgs.kdePackages.qt5compat ];
    autoNumlock = true;
    theme = "${pkgs.where-is-my-sddm-theme}/share/sddm/themes/where_is_my_sddm_theme";
  };

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
      settings = {
        globalOptions = {
          "Hotkey" = {
            "TriggerKeys" = null;
            "EnumerateWithTriggerKeys" = false;
            "AltTriggerKeys" = null;
            "EnumerateForwardKeys" = null;
            "EnumerateBackwardKeys" = null;
            "EnumerateGroupForwardKeys" = null;
            "EnumerateGroupBackwardKeys" = null;
          };
          "Hotkey/ActivateKeys" = {
            "0" = "Henkan";
            "1" = "Hangul";
          };
          "Hotkey/DeactivateKeys" = {
            "0" = "Muhenkan";
            "1" = "Hangul_Hanja";
          };
          "Behavior"."showInputMethodInformationWhenFocusIn" = true;
        };
        inputMethod = {
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "us";
            "DefaultIM" = "skk";
          };
          "Groups/0/Items/0"."Name" = "keyboard-us";
          "Groups/0/Items/1"."Name" = "skk";
          "GroupOrder"."0" = " Default";
        };
      };
    };
  };

  # Keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
