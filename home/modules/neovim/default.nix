{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.neovim.enable = lib.mkEnableOption "Neovim and all it deps";

  config = lib.mkIf config.localModules.neovim.enable {

    programs.neovim = {
      enable = true;

      extraPackages = with pkgs; [
        imagemagick
        python313Packages.jupytext

        clang
        ripgrep

        # typst
        tinymist
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

      extraLuaPackages =
        ps: with ps; [
          magick
        ];

      extraPython3Packages =
        ps: with ps; [
          pynvim
          jupyter-client
          nbformat
        ];
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.file.".config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/modules/neovim/src";
      recursive = true;
    };
  };
}
