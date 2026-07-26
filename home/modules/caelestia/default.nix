{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options.localModules.caelestia-shell.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.caelestia-shell.enable {
    home.packages = [ inputs.caelestia.packages.${pkgs.stdenv.hostPlatform.system}.with-cli ];

    mutableNix.links = [
      {
        root = "dahl-dotfiles";
        from = "caelestia/";
        to = "${config.home.homeDirectory}/.config/caelestia";
      }
    ];
  };
}
