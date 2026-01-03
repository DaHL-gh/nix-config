{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.localModules.agenix;
in
{
  imports = [ inputs.agenix.nixosModules.default ];

  options.localModules.agenix = {
    enable = lib.mkEnableOption "";

    secrets = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = { };
      description = "";
    };
  };

  config = lib.mkIf cfg.enable {
    age.secrets = lib.mapAttrs (name: path: { file = path; }) cfg.secrets;

    environment.systemPackages = [ inputs.agenix.packages.${pkgs.system}.default ];
  };
}
