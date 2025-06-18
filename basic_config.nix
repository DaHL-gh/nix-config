{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      home-manager.nixosModules.home-manager
    ];

  ##### NETWORKING
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = false;
  #   allowedTCPPorts = [ 80 443 ]; # Add ports as needed
  #   allowedUDPPorts = [ ... ]; # Add ports as needed
  #   allowPing = true;
  };

  # networking.nat = {
    # enable = true;
    # internalInterfaces = [ "tun0" ];
    # externalInterface = "enp4s0";
  # };
  # services.resolved.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  ##### BOOT #####
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ]; # efi only
  };
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
  };
  # boot.loader.grub.efiInstallAsRemovable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  networking.hostName = "dahl-b550m";
  time.timeZone = "Asia/Yekaterinburg";
  users.users.dahl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

  home-manager = {
	useGlobalPkgs = true;
	useUserPackages = true;

	users.dahl = import ./home.nix;
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  ##### PROGRAMS #####
  nixpkgs.config.allowUnfree = true; 
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty

    clang
    spotify
    telegram-desktop
    hiddify-app
    wl-clipboard
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  services.udev.extraRules = ''
  # Disable wakeup for PCI device 0000:00:01.1
    ACTION=="add", SUBSYSTEM=="pci", ATTR{bus}=="pci", ATTR{address}=="0000:00:01.1", ATTR{power/wakeup}="disabled"
  '';

  # move somewhere else
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## DO NOT CHANGE
  system.stateVersion = "24.11";
}

