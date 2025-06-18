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
			source = ./../dotfiles/hyprland;
			recursive = true;
		};

		".config/nvim/init.lua".source = ./../dotfiles/neovim/init.lua;
		".config/nvim/lazy-lock.json".source = ./../dotfiles/neovim/lazy-lock.json;
		".config/nvim/lua" = {
			source = ./../dotfiles/neovim/lua;
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
