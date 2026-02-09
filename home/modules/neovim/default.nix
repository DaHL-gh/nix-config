{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}:
{
  options.localModules.neovim.enable = lib.mkEnableOption "Neovim and all it deps";

  config = lib.mkIf config.localModules.neovim.enable {
    home.packages = with pkgs; [
      typst
      basedpyright
    ];

    programs.neovim = {
      enable = true;

      extraPackages = with pkgs; [
        imagemagick
        python313Packages.jupytext

        clang
        ripgrep

        yaml-language-server

        # typst
        tinymist
        typst
        # cpp
        llvmPackages_20.clang-tools

        # lua
        lua-language-server
        # nix
        nil
        nixfmt
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
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/modules/neovim/src";
      recursive = true;
    };
  };
}
