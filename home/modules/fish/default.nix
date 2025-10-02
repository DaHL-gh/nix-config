{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.fish.enable = lib.mkEnableOption "Just fish";

  config = lib.mkIf config.localModules.fish.enable {
    programs.fish = {
      enable = true;
      shellInit = "	direnv hook fish | source\n";
    };

    home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

    home.packages = with pkgs; [ direnv ];
  };
}
