{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.localModules.i18n.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.i18n.enable {
    i18n = {
      defaultLocale = "ru_RU.UTF-8";
    };
  };
}
