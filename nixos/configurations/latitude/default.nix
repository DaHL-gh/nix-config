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
      keyd.enable = true;
      home-manager.enable = true;
      nix-ld.enable = true;
    };

    ##### NETWORKING #####
    networking = {
      networkmanager.enable = true;
      firewall.enable = false;

      wireguard = {
        enable = true;
        interfaces = {
        };
      };
    };

    ##### SERVICES #####
    services = {
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

      logind = {
        settings.Login.HandleLidSwitch = "ignore";
      };

      tailscale.enable = true;
      resolved.enable = true;
    };
    virtualisation.docker.enable = true;

    ##### HOME MANAGER #####
    home-manager.users.dahl = {
      imports = [
        ../../../home/modules
      ];

      config = {
        home.stateVersion = "25.05";
        targets.genericLinux.enable = true;

        localModules = {
          # noctalia-shell.enable = true;
          # firefox.enable = true;
          # hyprland.enable = true;
          # kitty.enable = true;
          # spicetify.enable = true;
          fish.enable = true;
          git.enable = true;
          neovim.enable = true;
          tmux.enable = true;
          # xdg.enable = true;
          programCategories = [
            "cli"
            "programming"
            "networking"
          ];
        };

        fonts.fontconfig.enable = true;

        # gtk = {
        #   enable = true;
        #   cursorTheme.name = "Nordic-cursors";
        #   cursorTheme.size = 12;
        #   iconTheme.name = "Nordzy";
        #   theme.name = "Nordic";
        # };
      };
    };

    ##### PROGRAMS #####
    nixpkgs.config.allowUnfree = true;

    programs = {
      fish.enable = true;
      # hyprland.enable = true;
      # steam.enable = true;

      # throne = {
      #   enable = true;
      #   tunMode.enable = true;
      # };
    };

    environment.systemPackages = with pkgs; [ ];
  };
}
