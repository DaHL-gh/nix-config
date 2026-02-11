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
      rocm = {
        enable = true;
        hsaOverrideGfxVersion = "10.3.0";
      };
      agenix = {
        enable = true;
        secrets = {
          node-token = ../../../secrets/k3s/node-token.age;
          wg-preshared-key = ../../../secrets/wireguard/b550m/preshared-key.age;
          wg-private-key = ../../../secrets/wireguard/b550m/private-key.age;
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
            ips = [ "10.10.0.4/24" ];
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

    # qt = {
    #   enable = true;
    #   platformTheme = "qt5ct";
    # };

    services = {
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;

      openssh = {
        enable = true;
        settings = {
          GatewayPorts = "yes";
        };
      };

      spice-vdagentd.enable = true;

      udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
      '';

      sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
      };

      # k3s = {
      #   enable = true;
      #   role = "agent";
      #   serverAddr = "https://10.10.0.1:6443";
      #   tokenFile = config.age.secrets.node-token.path;
      #   nodeIP = "10.10.0.4";
      # };
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
