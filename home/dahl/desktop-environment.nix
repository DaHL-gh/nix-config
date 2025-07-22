{ config, pkgs, lib, ... }:
let 
	isDesktop = config.configurationName == "latitude" || 
		config.configurationName == "b550m";
in {
	imports = [
		./../modules/firefox
		./../modules/fish
		./../modules/neovim
		./../modules/hyprland
		./../modules/git
	];

	config = lib.mkIf isDesktop {
		home.packages = with pkgs; [
			# Terminal utils
			fastfetch		
			btop
			bat
			tree

			nix-search-cli

			# Desktop apps
			spotify
			telegram-desktop
			hiddify-app
			mission-center
		];
	};
}
