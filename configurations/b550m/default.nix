{ config, lib, pkgs, ... }:
let configurationName = "b550m";
in {
	imports = [
		./hardware.nix
		../common.nix
		../../users/dahl.nix
	];

	options.deviceName = lib.mkOption {
		type = lib.types.str;
	};

	config = {
		deviceName = "b550m";
		home-manager.users.dahl.configurationName = configurationName;
	};
}
