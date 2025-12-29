{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.localModules.pipewire.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.pipewire.enable {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
  };
}
