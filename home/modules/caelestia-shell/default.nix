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
      ".config/caelestia/shell.json".source = "${flakePath}/home/modules/caelestia/src/shell.json";
    };
  };
}
