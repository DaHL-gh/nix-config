{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.hyprland.enable = lib.mkEnableOption "Enable configuration linking and programs heavily related to Hyprland WM";

  config = lib.mkIf config.localModules.hyprland.enable {
    home.packages = with pkgs; [
      kitty
      ghostty
      hyprsome
      playerctl
      wl-clipboard
      brightnessctl
      xdg-desktop-portal-hyprland

      hyprshot
      jq
      grim
      slurp
      satty

      networkmanagerapplet
      blueman

      pulseaudio
      alsa-utils
      pwvucontrol
    ];
    
    services.hypridle.enable = true;

    mutableNix.links = [
      {
        root = "dahl-dotfiles";
        from = "hyprland/";
        to = "${config.home.homeDirectory}/.config/hypr";
      }
      {
        root = "dahl-dotfiles";
        from = "wallpapers/";
        to = "${config.home.homeDirectory}/Pictures/Wallpapers";
      }
    ];
  };
}
