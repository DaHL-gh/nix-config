{ config, lib, pkgs, ... }:
{
	options.localModules.neovim.enable = lib.mkEnableOption "Neovim and all it deps";

	config = lib.mkIf config.localModules.neovim.enable {
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
      nixfmt
    ];

		programs.neovim.enable = true;

		home.sessionVariables = { 
			EDITOR = "nvim";
		};

		home.shellAliases = {
			vi = "nvim";
		};

		home.file.".config/nvim/" = {
			source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/modules/neovim/src";
			recursive = true;
		};
	};
}

