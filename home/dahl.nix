{ config, pkgs, lib, ... }:
{
	imports = [
		./modules/neovim/nvim.nix
		./modules/hyprland/hypr.nix
		./modules/fish/fish.nix
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

		programs.firefox.enable = true;

		programs.git = {
			enable = true;
			userName = "DaHL";
			userEmail = "8tima18@gmail.com";

			extraConfig = {
				init.defaultBranch = "main";
			};
		};

		home.packages = with pkgs; [
			# Terminal utils
			fastfetch		
			btop
			bat
			tree

			nix-search-cli

			# Desktop apps
			pwvucontrol
			blueman
			spotify
			telegram-desktop
			hiddify-app
			mission-center
		];
	};
}

