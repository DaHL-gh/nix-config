{ config, pkgs, lib, ...}:
{
	options.localModules.git.enable = lib.mkEnableOption "Just git n else";

	config = lib.mkIf config.localModules.git.enable {
		programs.git = {
			enable = true;
			userName = "DaHL";
			userEmail = "8tima18@gmail.com";

			extraConfig = {
				init.defaultBranch = "main";
			};
		};

		home.packages = with pkgs; [
			gh
			lazygit
		];
	};
}
