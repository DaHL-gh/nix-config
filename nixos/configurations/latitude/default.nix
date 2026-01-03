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
      home-manager.enable = true;
      agenix = {
        enable = true;
        secrets = {
          wg-preshared-key = ../../../secrets/wireguard/latitude/preshared-key.age;
          wg-private-key = ../../../secrets/wireguard/latitude/private-key.age;
        };
      };
    };

    ##### NETWORKING #####
    networking = {
      networkmanager.enable = true;
      firewall.enable = false;

      wireguard = {
        enable = true;
        interfaces = {
          wg0 = {
            ips = [ "10.10.0.3/24" ];
            privateKeyFile = config.age.secrets.wg-private-key.path;
            peers = [
              {
                allowedIPs = [ "10.10.0.0/24" ];
                publicKey = "F3rPvhM0EvBIeC4XhpcdXtxMieffBquExGjk3R2coxU=";
                presharedKeyFile = config.age.secrets.wg-preshared-key.path;
                persistentKeepalive = 25;
                endpoint = "46.62.215.248:51820";
              }
            ];
          };
        };
      };
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
