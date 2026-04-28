{ pkgs, ... }:
{
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
}
