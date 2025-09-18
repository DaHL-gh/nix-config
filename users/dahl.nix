{ config, pkgs, inputs, ... }: {

  config = {
    users.users.dahl = {
      isNormalUser = true;
      extraGroups =
        [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
      shell = pkgs.fish;
      packages = [ inputs.caelestia-shell.packages.${pkgs.system}.with-cli ];
    };

    home-manager.users.dahl = import ./../home/dahl;
  };
}
