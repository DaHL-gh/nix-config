{
  config,
  lib,
  pkgs,
  flakePath,
  inputs,
  ...
}:
{
  options.localModules.noctalia-shell.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.noctalia-shell.enable {
    home.packages = [ inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    home.file = {
      ".config/noctalia/" = {
        source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/noctalia/src";
        recursive = true;
      };
    };
  };
}
