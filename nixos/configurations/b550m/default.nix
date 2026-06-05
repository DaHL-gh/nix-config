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
      trusted-users = [
        "root"
        "dahl"
      ];
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
        };
      };
    };

    ##### NETWORKING #####
    networking = {
      networkmanager.enable = true;
      firewall.enable = false;

      extraHosts = "";
    };

    ##### BOOT #####
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General.Experimental = true;
        };
      };

      alsa.enablePersistence = true;
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
      displayManager.ly.enable = true;

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

      tailscale.enable = true;
      resolved.enable = true;
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
          iconTheme.name = "Nordzy-yellow-dark";
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
      xfconf.enable = true;

      throne = {
        enable = true;
        tunMode.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
