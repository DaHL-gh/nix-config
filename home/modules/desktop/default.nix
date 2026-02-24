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

    gtk = {
      enable = true;
      cursorTheme.name = "Nordic-cursors";
      cursorTheme.size = 12;
      iconTheme.name = "Nordzy";
      theme.name = "Nordic";
    };

    home.packages = with pkgs; [
      # fonts
      iosevka-bin
      jetbrains-mono
      ipafont
      kochi-substitute

      nordic
      nordzy-icon-theme
      nwg-look
      powertop

      # Desktop apps
      anki
      bitwarden-desktop
      gimp
      google-chrome
      kdePackages.dolphin
      kdePackages.filelight
      kdePackages.kdenlive
      libreoffice-qt6
      mission-center
      nemo
      obs-studio
      obsidian
      onlyoffice-desktopeditors
      qalculate-qt
      qbittorrent
      telegram-desktop
      vesktop
      vlc
      vscode
      wireshark

      # gaming?
      wineWow64Packages.waylandFull
      winetricks
      lutris

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
