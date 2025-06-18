{
	description = "DaHL NixOS configurations";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }: 
	let
		system = "x86_64-linux";
	in 
	{
		nixosConfigurations = {
			b550m = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					./devices/b550m/b550m.nix
				] ++ import ./users/all.nix ;
				specialArgs = {
					inherit home-manager;
				};
			};
		};
	};
}
