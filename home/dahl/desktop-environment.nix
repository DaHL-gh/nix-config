{ config, pkgs, lib, ... }:
let
  isDesktop = (config.configurationName == "latitude"
    || config.configurationName == "b550m");
in {
  config = lib.mkIf isDesktop {
    localModules = {
      firefox.enable = true;
      fish.enable = true;
      git.enable = true;
      hyprland.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };

    home.packages = with pkgs; [
      # Terminal utils
      bat
      btop-rocm
      fastfetch
      gemini-cli
      nix-search-cli
      tree

      # Desktop apps
      gimp
      hiddify-app
      libreoffice-qt6
      mission-center
      nemo
      obsidian
      spotify
      telegram-desktop
      vesktop
    ];
  };
}
