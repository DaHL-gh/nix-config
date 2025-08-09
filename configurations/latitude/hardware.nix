{ config, lib, pkgs, modulesPath, ... }:
let
	basic_mounting_params = ["defaults" "nofail"];
	fs_mask = ["dmask=027" "fmask=027"];
	user_mask = ["uid=1000" "gid=1000"];

	ext4_mounting_params = basic_mounting_params;
	ntfs_mounting_params = basic_mounting_params ++ fs_mask ++ user_mask;
in {
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	environment.systemPackages = with pkgs; [
		mergerfs
	];

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

	fileSystems = {
		"/" = { 
			device = "/dev/sda7";
			fsType = "ext4";
		};

		"/boot/efi" = { 
			device = "/dev/sda1";
			fsType = "vfat";
		};

		"/mnt/arch" = { 
			device = "/dev/sda5";
			fsType = "ext4";
			options = ext4_mounting_params;
		};

		"/mnt/windows" = { 
			device = "/dev/sda3";
			fsType = "ntfs";
			options = ntfs_mounting_params;
		};

		"/home/dahl/projects" = {
			device = "/home/dahl/Programing:/mnt/arch/home/dahl/Programing/:/mnt/windows/Programming/";
			fsType = "fuse.mergerfs";
			options = ["allow_other" "nofail" "category.create=mfs"]; 
			# auto create where the most free space
		};
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
