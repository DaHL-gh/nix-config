{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.localModules.programCategories;

  categoryPackages = {
    cli = with pkgs; [
      age
      bat
      btop-rocm
      fastfetch
      file
      powertop
      tree

      gvfs
      cloc
      opencode
      gemini-cli
      unzip
      zip

      gemini-cli
    ];

    networking = with pkgs; [
      dig
      inetutils
      nftables
      openssl
      traceroute
      wget
      wireguard-tools
    ];

    nix = with pkgs; [
      nix-index
      nix-search-cli
    ];

    kubernetes = with pkgs; [
      k9s
      kubectl
      kubernetes-helm
    ];

    desktop-essentials = with pkgs; [
      imv
      kdePackages.filelight
      localsend
      mission-center
      qalculate-qt
      qbittorrent
      sioyek
      thunar
      thunar-archive-plugin
      file-roller
      zip
      unzip
      gnutar
      gzip
      bzip2
      xz
      wireshark

      inputs.helium.packages.${system}.default
    ];

    desktop = with pkgs; [
      anki
      bitwarden-desktop
      google-chrome
      libreoffice-qt6
      moonlight-qt
      obsidian
      onlyoffice-desktopeditors
      telegram-desktop
      vesktop
      vlc
      vscode
    ];

    creation = with pkgs; [
      gimp
      obs-studio
      kdePackages.kdenlive
      blender
    ];

    games = with pkgs; [
      wineWow64Packages.waylandFull
      winetricks
      lutris
      bottles
    ];

    virtualization = with pkgs; [
      qemu
      virt-manager
      virt-viewer
      virtio-win
      spice
      spice-gtk
      spice-protocol
      win-spice
    ];

    unsorted = with pkgs; [
      # fonts
      iosevka-bin
      ipafont
      jetbrains-mono
      kochi-substitute
      material-icons

      nordic
      nordzy-icon-theme
      nwg-look
    ];
  };
in
{
  options.localModules.programCategories = lib.mkOption {
    type = lib.types.listOf (lib.types.enum (builtins.attrNames categoryPackages));
    default = [ ];
    description = "List of enabled program categories";
  };

  config = lib.mkIf (cfg != [ ]) {
    home.packages = lib.mkMerge (map (name: categoryPackages.${name}) cfg);
  };
}
