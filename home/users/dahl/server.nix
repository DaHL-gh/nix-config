{
  config,
  pkgs,
  lib,
  configurationName,
  ...
}:
let
  ifServer = configurationName == "server";
in
{
  config = lib.mkIf ifServer {
    localModules = {
      fish.enable = true;
      git.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };

    home.packages = with pkgs; [
      bat
      btop
      fastfetch
      nix-search-cli
      tree
    ];
  };
}
