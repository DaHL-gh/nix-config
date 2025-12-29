{
  config,
  pkgs,
  inputs,
  flakePath,
  localUtils,
  configurationName,
  ...
}:
{
  config = {
    users.users.dahl = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
      ]; # Enable ‘sudo’ for the user.
      shell = pkgs.fish;
    };

    home-manager = {
      users = {
        dahl = import ../../home/users/dahl;
      };
      extraSpecialArgs = {
        inherit
          inputs
          flakePath
          localUtils
          configurationName
          ;
      };
    };
  };
}
