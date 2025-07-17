{ config, pkgs, ... }:
{
	home.packages = with pkgs; [ 
		clang
		ripgrep

		# lua
		lua-language-server 
		# nix
		nil 
		#python
		basedpyright
		ruff
		#docker
		docker-language-server 
		#web
		vscode-langservers-extracted
		tailwindcss-language-server
	];

	programs.neovim.enable = true;

	home.file.".config/nvim/" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/modules/neovim/src";
		recursive = true;
	};
}

