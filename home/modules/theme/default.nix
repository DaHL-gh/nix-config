{ config, lib, ... }: {
  options.localModules.theme = {
    enable = lib.mkEnableOption "GTK/Qt theme";

    name = lib.mkOption {
      type = lib.types.enum [ "nordic" "orchis" ];
      default = "nordic";
      description = "Which theme to use: nordic or orchis";
    };
  };

  # Общие Qt настройки (включены при любой теме)
  config = lib.mkIf config.localModules.theme.enable {
    qt.enable = true;
    qt.platformTheme.name = "qtct";
    qt.style.name = "kvantum";
  };

  imports = [
    ./themes/nordic.nix
    ./themes/orchis.nix
  ];
}