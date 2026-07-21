{ config, lib, pkgs, ... }:
lib.mkIf (config.localModules.theme.enable && config.localModules.theme.name == "nordic") {
  home.packages = with pkgs; [
    nordic
  ];

  gtk = {
    enable = true;
    cursorTheme.name = "Nordic-cursors";
    cursorTheme.size = 12;
    iconTheme.name = "Nordzy-yellow-dark";
    theme.name = "Nordic";
  };

  qt.kvantum = {
    enable = true;
    settings.General.theme = "Nordic";
    themes = with pkgs; [ nordic ];
  };
}