{ config, pkgs, lib, ... }:
let 
	isDesktop = config.configurationName == "latitude" || 
		config.configurationName == "b550m";
in {
	config = lib.mkIf isDesktop {
		localModules = {
			firefox.enable = true;
			fish.enable = true;
			git.enable = true;
			hyprland.enable = true;
			neovim.enable = true;
			tmux.enable = true;
		};

		home.packages = with pkgs; [
			# Terminal utils
			fastfetch		
			btop-rocm
			bat
			tree

			gemini-cli

			nix-search-cli

			# Desktop apps
			spotify
			telegram-desktop
			hiddify-app
			mission-center
			obsidian
			libreoffice-qt6
			gimp
			vesktop
		];
	};
}
