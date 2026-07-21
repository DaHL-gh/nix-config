{ config, lib, pkgs, ... }:
let
  orchisKdeSrc = pkgs.fetchFromGitHub {
    owner = "vinceliuice";
    repo = "Orchis-kde";
    rev = "b2a96919eee40264e79db402b915f926436100ad";
    hash = "sha256-mO1AVrnXNdg3Rftj0cQWef/RrBgSDy5kaMHagwKywEo="; # TODO: fix after first build
  };

  orchisKvantumTheme = pkgs.stdenv.mkDerivation {
    name = "orchis-kvantum-theme";
    src = orchisKdeSrc;
    installPhase = ''
      mkdir -p $out/share/Kvantum/Orchis
      cp -r Kvantum/Orchis/* $out/share/Kvantum/Orchis/
    '';
  };
in
lib.mkIf (config.localModules.theme.enable && config.localModules.theme.name == "orchis") {
  home.packages = with pkgs; [
    orchis-theme
    tela-icon-theme
    bibata-cursors
  ];

  gtk = {
    enable = true;
    cursorTheme.name = "Bibata-Modern-Classic";
    cursorTheme.size = 12;
    iconTheme.name = "Tela-dark";
    theme.name = "Orchis-Dark";
  };

  qt.kvantum = {
    enable = true;
    settings.General.theme = "OrchisDark";
    themes = [ orchisKvantumTheme ];
  };
}
