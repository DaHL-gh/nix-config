{ config, lib, pkgs, ... }:
let
  hyprModuleDir =
    "${config.home.homeDirectory}/nix-config/home/modules/hyprland";
in {
  options.localModules.hyprland.enable = lib.mkEnableOption
    "Enable configuration linking and programs heavily related to Hyprland WM";

  config = lib.mkIf config.localModules.hyprland.enable {
    home.packages = with pkgs; [
      kitty
      hyprsome
      playerctl
      wl-clipboard
      brightnessctl
      xdg-desktop-portal-hyprland

      hyprshot

      networkmanagerapplet
      blueman
      pwvucontrol
    ];

    home.file = {
      ".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${hyprModuleDir}/src/hyprland.conf";
      ".config/hypr/monitors.conf".source = config.lib.file.mkOutOfStoreSymlink
        "${hyprModuleDir}/src/monitors/${config.configurationName}.conf";
      "Pictures/Wallpapers/" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/nix-config/wallpapers";
        recursive = true;
      };
    };
  };
}
