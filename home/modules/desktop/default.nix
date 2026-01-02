{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.localModules.desktop.enable = lib.mkEnableOption "";
  config = lib.mkIf config.localModules.desktop.enable {
    localModules = {
      firefox.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      spicetify.enable = true;
    };

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      # fonts
      iosevka-bin
      jetbrains-mono

      # Desktop apps
      bitwarden-desktop
      gimp
      google-chrome
      libreoffice-qt6
      onlyoffice-desktopeditors
      mission-center
      nemo
      obsidian
      obs-studio
      telegram-desktop
      qalculate-qt
      vesktop
      vlc
      vscode
      #
      # # gaming?
      # wineWowPackages.waylandFull
      # winetricks
      # lutris
      #
      # # virtualization
      # qemu
      # virt-manager
      # virt-viewer
      # virtio-win
      # spice
      # spice-gtk
      # spice-protocol
      # win-virtio
      # win-spice
    ];
  };
}
