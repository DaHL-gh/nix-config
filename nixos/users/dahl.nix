{
  config,
  pkgs,
  inputs,
  flakePath,
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
        dahl = import ../../home/configurations/dahl // {
          configurationName = config.configurationName;
        };
      };
      extraSpecialArgs = {
        inherit inputs flakePath;
      };
    };
  };
}
