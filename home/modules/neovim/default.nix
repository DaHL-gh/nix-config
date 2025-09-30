{ config, lib, pkgs, ... }: {
  options.localModules.neovim.enable =
    lib.mkEnableOption "Neovim and all it deps";

  config = lib.mkIf config.localModules.neovim.enable {
    home.packages = with pkgs; [
      clang
      ripgrep

      # lua
      lua-language-server
      # nix
      nil
      nixfmt-rfc-style
      #python
      basedpyright
      ruff
      #docker
      docker-language-server
      docker-compose-language-service
      #web
      vscode-langservers-extracted
      tailwindcss-language-server
    ];

    programs.neovim.enable = true;

    home.sessionVariables = { EDITOR = "nvim"; };

    home.shellAliases = { vi = "nvim"; };

    home.file.".config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nix-config/home/modules/neovim/src";
      recursive = true;
    };
  };
}

