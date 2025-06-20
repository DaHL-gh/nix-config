{ config, lib, pkgs, home-manager, deviceName, ... }:

{
	imports = [ 
		home-manager.nixosModules.home-manager 
		./hardware/${deviceName}.nix
	];
	networking.hostName = deviceName;

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

	# todo: sort and move more to userspace
	##### PROGRAMS #####
	nixpkgs.config.allowUnfree = true; 
	programs.firefox.enable = true;
	programs.hyprland.enable = true;
	programs.fish.enable = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		hyprsome

		playerctl
		clang
		spotify
		telegram-desktop
		hiddify-app
		wl-clipboard
	];
}

