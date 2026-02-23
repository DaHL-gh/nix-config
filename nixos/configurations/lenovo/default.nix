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
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

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

      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
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
          DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

          # Бережем батарею (Lenovo Conservation Mode)
          # Если часто работаешь от сети, поставь 1. Это ограничит заряд на 60-80%.
          # У тебя сейчас 0 (заряжает до 100%).
          START_CHARGE_THRESH_BAT0 = 80;
          STOP_CHARGE_THRESH_BAT0 = 90;
        };
      };
      tlp.pd.enable = true;
      power-profiles-daemon.enable = false;
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
    home-manager.users.dahl = import ../../../home/configurations/dahl-desktop.nix;

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

    xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
