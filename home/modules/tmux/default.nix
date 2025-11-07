{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}:
{
  options.localModules.tmux.enable = lib.mkEnableOption "Tmux with config file";

  config = lib.mkIf config.localModules.neovim.enable {
    home.packages = with pkgs; [
      tmux
      skim
    ];

    home.file.".config/tmux/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/tmux/src/";
    };
  };
}
