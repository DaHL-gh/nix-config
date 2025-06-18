{ ... }:
{
	imports = [
		./hardware.nix
		../common.nix
	];
	networking.hostName = "b550m";
}
