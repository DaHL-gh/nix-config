{
  description = "dahl NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixpkgs-25-05.url = "github:NixOS/nixpkgs?ref=nixos-25.05";

    home-manager.url = "github:nix-community/home-manager?ref=master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    caelestia.url = "github:caelestia-dots/shell";
    caelestia.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    milk-grub-theme.url = "github:gemakfy/MilkGrub";
    milk-grub-theme.inputs.nixpkgs.follows = "nixpkgs";

    polyMc.url = "github:PolyMC/PolyMC";
    polyMc.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      flakePath = "/home/dahl/Documents/nix-config/";
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

      localUtils = import ./utils.nix { lib = nixpkgs.lib; };

      makeSystem =
        { deviceName }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs flakePath localUtils;
            configurationName = deviceName;
          };
          modules = [
            ./nixos/configurations/${deviceName}
            inputs.home-manager.nixosModules.home-manager
            inputs.milk-grub-theme.nixosModule
            { nixpkgs.overlays = [ hiddifyOverlay ]; }
          ];
        };

      makeHome =
        { username, deviceName }:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs flakePath localUtils;
            configurationName = deviceName;
          };
          modules = [
            ./home/users/${username}
          ];
        };
    in
    {
      nixosConfigurations = {
        b550m = makeSystem { deviceName = "b550m"; };
        latitude = makeSystem { deviceName = "latitude"; };
        lenovo = makeSystem { deviceName = "lenovo"; };
      };

      homeConfigurations = builtins.listToAttrs (
        builtins.concatMap (
          username:
          builtins.map
            (deviceName: {
              name = "${username}@${deviceName}";
              value = makeHome { inherit username deviceName; };
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
