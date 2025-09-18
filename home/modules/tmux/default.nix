{ config, lib, pkgs, ... }: {
  options.localModules.tmux.enable = lib.mkEnableOption "Tmux with config file";

  config = lib.mkIf config.localModules.neovim.enable {
    home.packages = with pkgs; [ tmux ];

    home.file.".config/tmux/" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nix-config/home/modules/tmux/src/";
    };
  };
}

