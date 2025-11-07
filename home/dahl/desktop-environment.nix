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
      btop-rocm
      fastfetch
      gemini-cli
      nftables
      nix-index
      nix-search-cli
      tree

      wineWowPackages.waylandFull
      winetricks
      
      # Desktop apps
      gimp
      google-chrome
      libreoffice-qt6
      mission-center
      nemo
      obsidian
      obs-studio
      telegram-desktop
      qalculate-qt
      vesktop
      vlc
      vscode
    ];
  };
}
