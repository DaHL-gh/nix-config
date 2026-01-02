{
  config,
  lib,
  pkgs,
  flakePath,
  configurationName,
  ...
}:
{
  options.localModules.hyprland.enable = lib.mkEnableOption "Enable configuration linking and programs heavily related to Hyprland WM";

  config = lib.mkIf config.localModules.hyprland.enable {
    localModules.caelestia-shell.enable = true;

    home.packages =
      with pkgs;
      [
        kitty
        hyprsome
        playerctl
        wl-clipboard
        brightnessctl
        xdg-desktop-portal-hyprland

        hyprshot

        networkmanagerapplet
        blueman

        pulseaudio
        alsa-utils
        pwvucontrol
      ];

    home.file = {
      ".config/hypr/hyprland.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/hyprland/src/hyprland.conf";
      ".config/hypr/monitors.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/hyprland/src/monitors/${configurationName}.conf";
      "Pictures/Wallpapers/" = {
        source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/wallpapers";
        recursive = true;
      };
    };
  };
}
