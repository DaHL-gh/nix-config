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
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
    };

    time.timeZone = "Asia/Yekaterinburg";

    localModules = {
      pipewire.enable = true;
      keyd.enable = true;
      home-manager.enable = true;
      rocm = {
        enable = true;
        hsaOverrideGfxVersion = "10.3.0";
      };
      nix-ld.enable = true;
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
      displayManager.sddm.wayland.enable = true;

      gvfs.enable = true;
      tumbler.enable = true;

      openssh = {
        enable = true;
        settings = {
          GatewayPorts = "yes";
        };
      };

      ollama = {
        enable = true;
        package = pkgs.ollama-rocm;
        rocmOverrideGfx = "10.3.0";
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

    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
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
      podman = {
        enable = true;
        extraPackages = with pkgs; [ podman-compose ];
      };
      waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
      };
    };

    ##### HOME MANAGER #####
    home-manager.users.dahl = {
      imports = [
        ../../../home/modules
      ];

      config = {
        home.stateVersion = "25.05";
        targets.genericLinux.enable = true;

        localModules = {
          noctalia-shell.enable = true;
          firefox.enable = true;
          hyprland.enable = true;
          kitty.enable = true;
          spicetify.enable = true;
          fish.enable = true;
          git.enable = true;
          neovim.enable = true;
          tmux.enable = true;
          xdg.enable = true;
          programCategories = [
            "cli"
            "networking"
            "nix"
            "kubernetes"
            "desktop"
            "desktop-essentials"
            "creation"
            "games"
            "virtualization"
            "unsorted"
          ];
        };

        fonts.fontconfig.enable = true;

        gtk = {
          enable = true;
          cursorTheme.name = "Nordic-cursors";
          cursorTheme.size = 12;
          iconTheme.name = "Nordzy";
          theme.name = "Nordic";
        };
      };
    };

    ##### PROGRAMS #####
    nixpkgs.config.allowUnfree = true;

    programs = {
      fish.enable = true;
      hyprland.enable = true;
      steam.enable = true;

      throne = {
        enable = true;
        tunMode.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
