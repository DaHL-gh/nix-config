{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  isDesktop = (config.configurationName == "latitude" || config.configurationName == "b550m");
in
{
  config = lib.mkIf isDesktop {
    localModules = {
      firefox.enable = true;
      fish.enable = true;
      git.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      spicetify.enable = true;
    };

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      # Terminal utils
      bat
      tree
      btop-rocm
      fastfetch
      gemini-cli
      nftables

      #nix
      nix-index
      nix-search-cli

      # net
      openssl
      dig
      traceroute

      # kuber
      kubernetes-helm
      k9s

      # archive
      zip
      unzip

      # fonts
      iosevka-bin
      jetbrains-mono

      # Desktop apps
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

      # gaming?
      wineWowPackages.waylandFull
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
      win-virtio
      win-spice
    ];
  };
}
