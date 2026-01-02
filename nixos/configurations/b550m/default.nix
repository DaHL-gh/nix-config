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
    deviceName = "nix-machine";
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
      home-manager.enable = true;
    };
    ##### NETWORKING #####
    networking = {
      networkmanager.enable = true;
      firewall.enable = false;

      extraHosts = ''
        127.0.0.1 nginx.local
        127.0.0.1 django-polls.local
        127.0.0.1 hobbie.local
      '';
    };

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
      displayManager.ly.enable = true;
      desktopManager.plasma6.enable = true;

      openssh = {
        enable = true;
        settings = {
          GatewayPorts = "yes";
        };
      };

      spice-vdagentd.enable = true;
    };

    ##### VIRTUALIZATION #####
    virtualisation = {
      docker.enable = true;
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
    };

    ##### HOME MANAGER #####
    home-manager.users.dahl = import ../../../home/configurations/dahl-desktop.nix;

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
