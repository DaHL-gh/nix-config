{ config, pkgs, ... }:
{

	config = {
		users.users.dahl = {
			isNormalUser = true;
			extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
			shell = pkgs.fish;
			packages = with pkgs; [ ];
		};

		home-manager.users.dahl = import ./../home/dahl.nix;
	};
}
