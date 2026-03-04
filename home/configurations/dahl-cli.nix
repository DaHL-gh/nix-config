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
      fish.enable = true;
      git.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      programCategories = [
        "cli"
        "networking"
        "kubernetes"
      ];
    };
  };
}
