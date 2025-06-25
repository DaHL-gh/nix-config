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
		efi.canTouchEfiVariables = false;
		grub = {
			enable = true;
			efiSupport = true;
			devices = [ "nodev" ]; # efi only
		};
		efi.efiSysMountPoint = "/boot/efi"; 
	};

	##### AUDIO #####
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	##### HOME MANAGER #####
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;

	};

	# todo: move to user env
	environment.variables = {
		EDITOR = "nvim";
	};

	##### PROGRAMS #####
	nixpkgs.config.allowUnfree = true; 

	programs.fish.enable = true;
	programs.hyprland.enable = true;

	environment.systemPackages = with pkgs; [];
}

