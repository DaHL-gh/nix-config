{ ... }:
{
  imports = [
    ../modules
  ];

  config = {
    home.stateVersion = "25.05";
    home.username = "dahl";
    home.homeDirectory = "/home/dahl";
    targets.genericLinux.enable = true;

    localModules = {
      cliUtils.enable = true;
    };
  };
}
