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
		makeSystem = { deviceName }:
			nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [ 
					./configuration.nix 
					./users/dahl.nix
				];
				specialArgs = { inherit home-manager; inherit deviceName; };
			};
	in 
	{
		nixosConfigurations = {
			b550m = makeSystem { deviceName = "b550m"; };
			latitude = makeSystem { deviceName = "latitude"; };
		};
	};
}
