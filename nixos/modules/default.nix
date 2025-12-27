{ lib, ... }:
{
  imports = [
    ./keyd.nix
    ./pipewire.nix
  ];

  options = {
    configurationName = lib.mkOption { type = lib.types.str; };
  };
}
