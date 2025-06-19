
{ ... }:
{
	imports = [
		./hardware.nix
		../common.nix
	];
	networking.hostName = "latitude";
}
