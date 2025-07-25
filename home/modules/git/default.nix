{ config, pkgs, lib, ...}:
{
	config = {
		programs.git = {
			enable = true;
			userName = "DaHL";
			userEmail = "8tima18@gmail.com";

			extraConfig = {
				init.defaultBranch = "main";
			};
		};

		home.packages = with pkgs; [
			lazygit
		];
	};
}
