{ pkgs, ... }:
{
  ### SYSTEM 
  users.users.dahl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };
  ### HOME MANAGER
  home-manager.users.dahl = {config, pkgs, ...}: {
	home.stateVersion = "25.05";
	programs.neovim.enable = true;

	home.file = {
		".config/hypr/" = {
			source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/hyprland";
			recursive = true;
		};

		".config/nvim/" = {
			source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/neovim";
			recursive = true;
		};
	};

	programs.git = {
		enable = true;
		userName = "DaHL";
		userEmail = "8tima18@gmail.com";

		extraConfig = {
			init.defaultBranch = "main";
		};
	};

	home.packages = with pkgs; [
		kitty
		lua-language-server
		nil
		neofetch
		btop
		bat
		tree
	];

	programs.fish.enable = true;
};
}
