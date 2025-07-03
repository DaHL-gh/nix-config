
{ config, pkgs, lib, modulesPath, ... }:
{
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ ];

	fileSystems."/" = { 
		device = "/dev/disk/by-uuid/73fc163e-2810-4ffc-a977-4e9af4b0000e";
		fsType = "ext4";
	};

	fileSystems."/boot/efi" = { 
		device = "/dev/nvme0n1p1";
		fsType = "vfat";
	};

	fileSystems."/mnt/windows" = { 
		device = "/dev/nvme0n1p3";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/nvme" = { 
		device = "/dev/nvme0n1p5";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/arch" = { 
		device = "/dev/nvme0n1p6";
		fsType = "ext4";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/ssd" = { 
		device = "/dev/sda3";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/hdd" = { 
		device = "/dev/sdb1";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	swapDevices = [ ];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
