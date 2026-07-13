{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}:
{
  options.localModules.ghostty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.kitty.enable {
    home.packages = with pkgs; [
      ghostty
    ];

    home.file.".config/ghostty/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/ghostty/src";
      recursive = true;
    };
  };
}
