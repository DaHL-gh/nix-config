{ config, pkgs, lib, modulesPath, ... }:
{
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	boot = {
		initrd = {
			availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
			kernelModules = [ ];
		};
		kernelModules = [ "kvm-amd" ];
		extraModulePackages = [ ];

		resumeDevice = "/dev/nvme0n1p7";
		kernelParams = [
			"resume=/dev/sda7"
			"resume_offset=24481792"
		];
	};

	swapDevices = [{
		device = "/swapfile";
		size = 16384;
	}];

	fileSystems."/" = { 
		device = "/dev/disk/by-uuid/73fc163e-2810-4ffc-a977-4e9af4b0000e";
		fsType = "ext4";
	};

	fileSystems."/boot/efi" = { 
		device = "/dev/disk/by-uuid/CE00-4ED0";
		fsType = "vfat";
	};

	fileSystems."/mnt/windows" = { 
		device = "/dev/disk/by-uuid/C022D7B122D7AAA4";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/nvme" = { 
		device = "/dev/disk/by-uuid/08CAC260CAC249A0";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/arch" = { 
		device = "/dev/disk/by-uuid/e1344cb1-760a-4886-af76-fc281e3a726e";
		fsType = "ext4";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/ssd" = { 
		device = "/dev/disk/by-uuid/AE3E3B8A3E3B4B1B";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	fileSystems."/mnt/hdd" = { 
		device = "/dev/disk/by-uuid/C252CF0B52CF0361";
		fsType = "ntfs";
		options = [ "defaults" "nofail" ];
	};

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware = {
		cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

		amdgpu = {
			opencl.enable = true;
			# initrd.enable = true;
			amdvlk.enable = true;
		};
	};
}
