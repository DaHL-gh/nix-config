{ config, pkgs, lib, ... }:
{
	imports = [
		./server.nix
		./desktop-environment.nix

		./../modules/firefox
		./../modules/fish
		./../modules/git
		./../modules/neovim
		./../modules/hyprland
	];

	options = {
		configurationName = lib.mkOption {
			type = lib.types.str;
		};
	};

	config = {
		home.stateVersion = "25.05";
		home.username = "dahl";
		home.homeDirectory = "/home/dahl";
		targets.genericLinux.enable = true;
	};
}

