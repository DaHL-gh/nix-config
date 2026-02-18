{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}:
let
  basic_mounting_params = [
    "defaults"
    "nofail"
  ];
  fs_mask = [
    "dmask=027"
    "fmask=027"
  ];
  user_mask = [
    "uid=1000"
    "gid=1000"
  ];

  ext4_mounting_params = basic_mounting_params;
  ntfs_mounting_params = basic_mounting_params ++ fs_mask ++ user_mask;
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  environment.systemPackages = with pkgs; [ mergerfs ];

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ]; # efi only
        milk-theme.enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "kvm-amd"
      # "vfio_pci"
      # "vfio"
      # "vfio_iommu_typ1"
      # "vfio_virqfd"
    ];
    extraModulePackages = [ ];

    resumeDevice = "/dev/nvme0n1p7";
    kernelParams = [
      "resume=/dev/sda7"
      "resume_offset=24481792"
      # "amd_iommu=on"
      # "iommu=pt"
      # "vfio-pci.ids=1002:73ff,1002:ab28"
    ];
    # blacklistedKernelModules = [ "amdgpu" ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16384;
    }
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/73fc163e-2810-4ffc-a977-4e9af4b0000e";
      fsType = "ext4";
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/CE00-4ED0";
      fsType = "vfat";
    };

    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/C022D7B122D7AAA4";
      fsType = "ntfs";
      options = ntfs_mounting_params;
    };

    "/mnt/nvme" = {
      device = "/dev/disk/by-uuid/08CAC260CAC249A0";
      fsType = "ntfs";
      options = ntfs_mounting_params;
    };

    "/mnt/arch" = {
      device = "/dev/disk/by-uuid/e1344cb1-760a-4886-af76-fc281e3a726e";
      fsType = "ext4";
      options = ext4_mounting_params;
    };

    "/mnt/ssd" = {
      device = "/dev/disk/by-uuid/AE3E3B8A3E3B4B1B";
      fsType = "ntfs";
      options = ntfs_mounting_params;
    };

    "/mnt/hdd" = {
      device = "/dev/disk/by-uuid/C252CF0B52CF0361";
      fsType = "ntfs";
      options = ntfs_mounting_params;
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;

    amdgpu = {
      opencl.enable = true;
      # initrd.enable = true;
      # amdvlk.enable = true; -- it was replaced by mesa driver, should work out of box
    };
  };
}
