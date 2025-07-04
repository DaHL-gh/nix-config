{ config, lib, pkgs, ... }:
let deviceName = "b550m";
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
		inherit deviceName;
		home-manager.users.dahl.deviceName = deviceName;
	};
}
