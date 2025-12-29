{ inputs, ... }:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.caelestia-shell.homeManagerModules.default

    ./server.nix
    ./desktop-environment.nix
    ../../modules
  ];

  config = {
    home.stateVersion = "25.05";
    home.username = "dahl";
    home.homeDirectory = "/home/dahl";
    targets.genericLinux.enable = true;
  };
}
