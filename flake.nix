{
  description = "DaHL NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixpkgs-25-05.url = "github:NixOS/nixpkgs?ref=nixos-25.05";

    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ hiddifyOverlay ];
      };
      pkgs-25-05 = import inputs.nixpkgs-25-05 {
        inherit system;
        config.allowUnfree = true;
      };

      hiddifyOverlay = final: prev: {
        hiddify = pkgs-25-05.hiddify-app;
      };

      makeSystem =
        { deviceName }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            flakePath = toString ./.;
          };
          modules = [
            # { _module.args = { inherit inputs; }; }
            ./configurations/${deviceName}
            inputs.home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [ hiddifyOverlay ];

            }
          ];
        };

      makeHome =
        username: deviceName:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/dahl
            { configurationName = deviceName; }
          ];
        };
    in
    {
      nixosConfigurations = {
        b550m = makeSystem { deviceName = "b550m"; };
        latitude = makeSystem { deviceName = "latitude"; };
      };

      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap (
          user:
          builtins.map
            (device: {
              name = "${user}@${device}";
              value = makeHome user device;
            })
            [
              "server"
              "b550m"
              "latitude"
            ]
        ) [ "dahl" ]
      );
    };
}
