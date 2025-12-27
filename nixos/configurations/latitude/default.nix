{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix

    ../../users/dahl.nix
    ../../modules
  ];

  options.deviceName = lib.mkOption { type = lib.types.str; };

  config = {
    deviceName = "nix-book";

    networking.hostName = config.deviceName;

    system.stateVersion = "24.11";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "Asia/Yekaterinburg";

    localModules = {
      pipewire.enable = true;
      keyd.enable = true;
    };
    ##### NETWORKING #####
    networking.networkmanager.enable = true;

    networking.firewall.enable = false;

    ##### BOOT #####

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.Experimental = true;
      };
    };

    ##### SERVICES #####
    security = {
      rtkit.enable = true;
    };

    services = {
      upower = {
        enable = true;
      };

      displayManager.ly.enable = true;
      desktopManager = {
        cosmic.enable = true;
        plasma6.enable = true;
        gnome.enable = true;
      };

      openssh = {
        enable = true;
        settings = {
          GatewayPorts = "yes";
        };
      };

      logind = {
        settings.Login.HandleLidSwitch = "ignore";
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

    programs = {
      fish.enable = true;
      hyprland.enable = true;
      nix-ld = {
        enable = true;
        libraries = with pkgs; [ fuse ];
      };
      steam.enable = true;
      throne = {
        enable = true;
        tunMode.enable = true;
      };
    };

    xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
