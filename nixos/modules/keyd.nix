{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.localModules.keyd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.keyd.enable {
    services = {
      keyd = {
        enable = true;
        keyboards.default = {
          settings = {
            main = {
              capslock = "layer(control)";
            };
            # right alt
            altgr = {
              h = "left";
              j = "down";
              k = "up";
              l = "right";
              u = "pageup";
              d = "pagedown";
              b = "home";
              f = "end";
            };
            control = {
              "[" = "esc";
            };
          };
        };
      };
    };
  };
}
