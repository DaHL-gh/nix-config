{config, pkgs, ... }:
{
	home.packages = with pkgs; [ 
		clang
		ripgrep

		lua-language-server 
		nil
	];

	programs.neovim.enable = true;

	home.file.".config/nvim/" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/modules/neovim/src";
		recursive = true;
	};
}

