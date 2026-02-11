{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.localModules.rocm;
in
{
  options.localModules.rocm = {
    enable = lib.mkEnableOption "";
    hsaOverrideGfxVersion = lib.mkOption {
      type = lib.types.str;
      description = "";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config = {
      rocmSupport = true;
    };

    environment.systemPackages = with pkgs; [
      # ROCm runtime
      rocmPackages.rocm-runtime
      rocmPackages.rocblas
      rocmPackages.hipblas
      rocmPackages.miopen
      rocmPackages.rccl

      nvtopPackages.amd
      amdgpu_top
    ];

    environment.variables = {
      ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
      HSA_OVERRIDE_GFX_VERSION = cfg.hsaOverrideGfxVersion;
    };
  };
}
