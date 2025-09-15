{ config, pkgs, lib, ... }:
let
	ifServer = config.configurationName == "server";
in {
	config = lib.mkIf ifServer {
		localModules = {
			fish.enable = true;
			git.enable = true;
			neovim.enable = true;
			tmux.enable = true;
		};

		home.packages = with pkgs; [
			fastfetch		
			btop
			bat
			tree

			nix-search-cli
		];
	};
}
