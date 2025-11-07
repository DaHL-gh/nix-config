{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    
    ./server.nix
    ./desktop-environment.nix

    ./../modules/firefox
    ./../modules/fish
    ./../modules/git
    ./../modules/kitty
    ./../modules/hyprland
    ./../modules/neovim
    ./../modules/tmux
    ./../modules/spicetify
  ];

  options = {
    configurationName = lib.mkOption { type = lib.types.str; };
  };

  config = {
    home.stateVersion = "25.05";
    home.username = "dahl";
    home.homeDirectory = "/home/dahl";
    targets.genericLinux.enable = true;
  };
}
