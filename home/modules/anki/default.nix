{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.anki.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.anki.enable {
    programs.anki = {
      enable = true;
      addons = with pkgs; [
        ankiAddons.anki-connect
      ];
    };
  };
}
