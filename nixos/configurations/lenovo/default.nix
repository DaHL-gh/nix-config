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
    deviceName = "kitayoza";

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
      nix-ld.enable = true;
      agenix = {
        enable = true;
        secrets = {
          wg-preshared-key = ../../../secrets/wireguard/lenovo/preshared-key.age;
          wg-private-key = ../../../secrets/wireguard/lenovo/private-key.age;
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
            ips = [ "10.10.0.5/24" ];
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
        General = {
          Experimental = true;
          FastConnectable = true;
          ControllerMode = "bredr";
          Disable = "Headset,Handsfree,Gateway";
        };
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

      fwupd.enable = true;
      gvfs.enable = true;
      tumbler.enable = true;

      displayManager = {
        ly.enable = true;
        sddm = {
          enable = false;
          wayland.enable = true;
        };
      };
      desktopManager = { };

      openssh = {
        enable = true;
        settings = {
          GatewayPorts = "yes";
        };
      };

      logind = {
        settings.Login = {
          HandleLidSwitch = "suspend";
          HandlePowerKey = "suspend";
        };
      };

      tlp = {
        enable = true;
        settings = {
          # Процессор и платформа
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          PLATFORM_PROFILE_ON_BAT = "low-power";

          # Экономия энергии на шине PCIe (Критично!)
          # PCIE_ASPM_ON_BAT = "powersave";

          # Графика AMD: уровень 3 — золотая середина
          AMDGPU_ABM_LEVEL_ON_BAT = 3;

          # Диски
          DISK_IOSCHED = "none"; # Для NVMe планировщик не нужен

          # Радиомодули (отключаем Bluetooth, если не нужен в пути)
          # DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
        };
      };
      tlp.pd.enable = true;
      power-profiles-daemon.enable = false;

      immich = {
        enable = true;
        host = "0.0.0.0";
      };
    };

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
            "creation"
            "networking"
            "nix"
            "kubernetes"
            "desktop"
            "desktop-essentials"
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

    documentation.man.generateCaches = false; # disable fish cache generation
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
