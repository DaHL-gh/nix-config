{
	description = "DaHL NixOS configurations";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		caelestia-shell = {
			url = "github:DaHL-gh/caelestia-shell";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: 
	let
		system = "x86_64-linux";

		makeSystem = { deviceName }:
			nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [ 
				    { _module.args = { inherit inputs; }; }
					./configurations/${deviceName}/default.nix
					inputs.home-manager.nixosModules.home-manager 
				];
			};

		makeHome = username: deviceName: inputs.home-manager.lib.homeManagerConfiguration {
			pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
			modules = [ 
				./home/${username}.nix 
				({ config, ... }:{ config.configurationName = deviceName; })
			];
		};
	in 
	{
		nixosConfigurations = {
			b550m = makeSystem { deviceName = "b550m"; };
			latitude = makeSystem { deviceName = "latitude"; };
		};

		homeConfigurations = builtins.listToAttrs (
			builtins.concatMap (user:
				builtins.map (device: {
					name = "${user}@${device}";
					value = makeHome user device;
				}) [ "server" "b550m" "latitude" ]
			) [ "dahl" ]
		);
	};
}
