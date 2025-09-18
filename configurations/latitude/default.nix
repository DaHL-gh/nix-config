{ config, lib, pkgs, ... }:
let configurationName = "latitude";
in {
  imports = [ ./hardware.nix ../common.nix ../../users/dahl.nix ];

  options.deviceName = lib.mkOption { type = lib.types.str; };

  config = {
    deviceName = "nix-book";
    home-manager.users.dahl.configurationName = configurationName;
  };
}
