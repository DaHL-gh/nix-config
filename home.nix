{config, pkgs, ...}:
{
	home.stateVersion = "25.05";
	programs.neovim.enable = true;
	programs.git = {
		enable = true;
		userName = "DaHL";
		userEmail = "8tima18@gmail.com";

		extraConfig = {
			init.defaultBranch = "main";
		};
	};

	home.packages = with pkgs; [
		lua-language-server
		nil
		neofetch
		btop
		bat
		tree
	];

	programs.fish.enable = true;
}

