{
  config,
  lib,
  pkgs,
  flakePath,
  inputs,
  ...
}:
{
  options.localModules.caelestia-shell.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.caelestia-shell.enable {
    home.packages = [ inputs.caelestia.packages.${pkgs.stdenv.hostPlatform.system}.with-cli ];

    home.file = {
      ".config/caelestia/" = {
        source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/caelestia/src";
        recursive = true;
      };
    };
  };
}
