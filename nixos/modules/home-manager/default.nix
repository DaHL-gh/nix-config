{
  inputs,
  flakePath,
  localUtils,
  configurationName,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.localModules.home-manager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit
          inputs
          flakePath
          localUtils
          configurationName
          ;
      };
    };
  };
}
