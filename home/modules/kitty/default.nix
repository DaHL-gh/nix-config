{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}:
{
  options.localModules.kitty.enable = lib.mkEnableOption "Kitty term emulator settings";

  config = lib.mkIf config.localModules.kitty.enable {
    home.packages = with pkgs; [
      kitty

      jetbrains-mono
    ];

    home.file.".config/kitty/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/kitty/src";
      recursive = true;
    };
  };
}
