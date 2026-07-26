{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options.localModules.noctalia-shell.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.noctalia-shell.enable {
    home.packages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.quickshell
    ];

    mutableNix.links = [
      {
        root = "dahl-dotfiles";
        from = "noctalia/";
        to = "${config.home.homeDirectory}/.config/noctalia";
      }
    ];
  };
}
