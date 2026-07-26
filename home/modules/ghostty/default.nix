{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.ghostty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.ghostty.enable {
    home.packages = with pkgs; [
      ghostty
    ];

    mutableNix.links = [
      {
        root = "dahl-dotfiles";
        from = "ghostty/";
        to = "${config.home.homeDirectory}/.config/ghostty";
      }
    ];
  };
}
