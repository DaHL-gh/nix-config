{ config, pkgs, ... }:
{
	networking.hostName = config.deviceName;

	system.stateVersion = "24.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	time.timeZone = "Asia/Yekaterinburg";

	##### NETWORKING #####
	networking.networkmanager.enable = true;

	networking.firewall.enable = false;

	##### BOOT #####
	boot.loader = {
		grub = {
			enable = true;
			efiSupport = true;
			devices = [ "nodev" ]; # efi only
		};
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/efi"; 
		};
	};

	##### SERVICES #####
	# audio
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	# display manager
	services.displayManager.ly.enable = true;

	##### HOME MANAGER #####
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
	};

	##### PROGRAMS #####
	nixpkgs.config.allowUnfree = true; 

	programs.fish.enable = true;
	programs.hyprland.enable = true;

	environment.systemPackages = with pkgs; [];
}

