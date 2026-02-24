{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options.localModules.desktop.enable = lib.mkEnableOption "";
  config = lib.mkIf config.localModules.desktop.enable {
    localModules = {
      noctalia-shell.enable = true;
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
      qbittorrent
      vesktop
      vlc
      vscode
      wireshark

      # gaming?
      wineWow64Packages.waylandFull
      winetricks
      lutris

      powertop
      nwg-look
      kdePackages.dolphin
      kdePackages.filelight
      # kdePackages.kdenlive
      # ffmpeg

      # virtualization
      qemu
      virt-manager
      virt-viewer
      virtio-win
      spice
      spice-gtk
      spice-protocol
      win-spice
    ];
  };
}
