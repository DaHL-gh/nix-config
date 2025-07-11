{config, pkgs, ... }:
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
		vscode-langservers-extracted
	];

	programs.neovim.enable = true;

	home.file.".config/nvim/" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/modules/neovim/src";
		recursive = true;
	};
}

