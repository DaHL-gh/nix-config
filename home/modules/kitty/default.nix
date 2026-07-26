{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.kitty.enable = lib.mkEnableOption "Kitty term emulator settings";

  config = lib.mkIf config.localModules.kitty.enable {
    home.packages = with pkgs; [
      kitty
    ];

    mutableNix.links = [
      {
        root = "dahl-dotfiles";
        from = "kitty/";
        to = "${config.home.homeDirectory}/.config/kitty";
      }
    ];
  };
}
