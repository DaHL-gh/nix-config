{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.bitwarden.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.bitwarden.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];

    programs.rbw = {
      enable = true;
      settings.email = "8tima18@gmail.com";
      settings.pinentry = pkgs.pinentry-curses;
    };
  };
}
