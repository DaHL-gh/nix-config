{ config, lib, pkgs, modulesPath, ... }:
{
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	boot = {
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
			kernelModules = [ ];
		};
		kernelModules = [ "kvm-intel" ];
		extraModulePackages = [ ];

		resumeDevice = "/dev/sda7";
		kernelParams = [
			"resume=/dev/sda7"
			"resume_offset=37263360"
		];
	};

	fileSystems."/" = { 
		device = "/dev/sda7";
		fsType = "ext4";
	};

	fileSystems."/boot/efi" = { 
		device = "/dev/sda1";
		fsType = "vfat";
	};

	fileSystems."/mnt/arch" = { 
		device = "/dev/sda5";
		fsType = "ext4";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/windows" = { 
		device = "/dev/sda3";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	swapDevices = [{
		device = "/swapfile";
		size = 8192;
	}];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
	# networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
