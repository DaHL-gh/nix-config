{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.tmux.enable = lib.mkEnableOption "Tmux with config file";

  config = lib.mkIf config.localModules.tmux.enable {
    home.packages = with pkgs; [
      tmux
      skim
    ];

    mutableNix.links = [
      {
        root = "dahl-dotfiles";
        from = "tmux/";
        to = "${config.home.homeDirectory}/.config/tmux";
      }
    ];
  };
}
