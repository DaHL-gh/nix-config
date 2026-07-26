{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.localModules.neovim.enable = lib.mkEnableOption "Neovim and all it deps";

  config = lib.mkIf config.localModules.neovim.enable {
    home.packages = with pkgs; [
      clang
      ripgrep
      tree-sitter

      # cpp
      llvmPackages_20.clang-tools
      # docker
      docker-language-server
      docker-compose-language-service
      # html + css + js + ts
      vscode-langservers-extracted
      tailwindcss-language-server
      typescript
      typescript-language-server
      # lua
      lua-language-server
      # nix
      nil
      nixfmt
      # python
      basedpyright
      ruff
      # qml
      kdePackages.qtdeclarative
      # typst
      tinymist
      typst
      # yaml
      yaml-language-server
    ];

    programs.neovim = {
      enable = true;
      withRuby = false;
      withPython3 = false;
      sideloadInitLua = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    mutableNix.links = [
      {
        root = "dahl-dotfiles"; # name of mutable root
        from = "neovim/"; # path in mutable root
        to = "${config.home.homeDirectory}/.config/nvim"; # path where to create symlink
      }
    ];
  };
}
