{
  config,
  lib,
  pkgs,
  inputs,
  flakePath,
  ...
}:
{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];

  options.localModules.caelestia-shell.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.caelestia-shell.enable {
    programs.caelestia = {
      enable = true;
      systemd.enable = false;
    };

    home.packages = with inputs.caelestia-shell.packages.${pkgs.system}; [
      with-cli
    ];

    home.file = {
      ".config/caelestia/shell.json".source =
        config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/caelestia-shell/src/shell.json";
    };
  };
}
