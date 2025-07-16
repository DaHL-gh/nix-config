{ config, pkgs, ... }:
{
	programs.fish = {
		enable = true;
		shellInit = ''
			direnv hook fish | source
		'';
	};

	home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

	home.packages = with pkgs; [
		direnv
	];
}
