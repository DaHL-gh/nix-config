{ config, lib, pkgs, home-manager, ... }:

{
  system.stateVersion = "24.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [ 
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

  home-manager = {
	useGlobalPkgs = true;
	useUserPackages = true;
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
    clang
    spotify
    telegram-desktop
    hiddify-app
    wl-clipboard
  ];
}

