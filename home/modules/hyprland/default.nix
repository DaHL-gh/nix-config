{
  config,
  lib,
  pkgs,
  inputs,
  flakePath,
  ...
}:
{
  options.localModules.hyprland.enable = lib.mkEnableOption "Enable configuration linking and programs heavily related to Hyprland WM";

  config = lib.mkIf config.localModules.hyprland.enable {
    programs.caelestia = {
      enable = true;
      systemd.enable = false;
    };

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
      ]
      ++ ([
        inputs.caelestia-shell.packages.${pkgs.system}.with-cli
      ]);

    home.file = {
      ".config/hypr/hyprland.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/hyprland/src/hyprland.conf";
      ".config/hypr/monitors.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/hyprland/src/monitors/${config.configurationName}.conf";
      "Pictures/Wallpapers/" = {
        source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/wallpapers";
        recursive = true;
      };
    };
  };
}
