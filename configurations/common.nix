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

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General.Experimental = true;
		};
	};

	##### SERVICES #####
	# audio
	services = {
		pipewire = {
			enable = true;
			pulse.enable = true;
			alsa.enable = true;
			jack.enable = true;
		};

		upower = {
			enable = true;
		};

		displayManager.ly.enable = true;

		openssh = {
			enable = true;
			settings = {
				GatewayPorts = "yes";
			};
		};

		keyd = {
			enable = true;
			keyboards.default = {
				settings = {
					main = {
						capslock = "layer(control)"; 
					};
					altgr = { # right alt
						h = "left";
						j = "down";
						k = "up";
						l = "right";
						u = "pageup";
						d = "pagedown";
						b = "home";
						f = "end";
					};
					control = { # control
						"[" = "esc";
					};
				};
			};
		};
	};
	virtualisation.docker.enable = true;

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

