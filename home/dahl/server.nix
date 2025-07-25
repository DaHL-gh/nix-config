{ config, pkgs, lib, ... }:
let
	ifServer = config.configurationName == "server";
in {
	imports = [ 
		./../modules/fish
		./../modules/neovim
		./../modules/git
	];

	config = lib.mkIf ifServer {
		home.packages = with pkgs; [
			fastfetch		
			btop
			bat
			tree
			tmux

			nix-search-cli
		];
	};
}
