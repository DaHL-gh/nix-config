{ config, pkgs, lib, ... }:
{
	options.localModules.firefox.enable = lib.mkEnableOption "Litteraly firefox idk";

	config = lib.mkIf config.localModules.firefox.enable {
		programs.firefox.enable = true;
	};
}
