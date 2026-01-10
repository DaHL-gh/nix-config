{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.localModules.cliUtils.enable = lib.mkEnableOption "";

  config = lib.mkIf config.localModules.cliUtils.enable {
    localModules = {
      fish.enable = true;
      git.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };

    home.packages = with pkgs; [
      # Terminal utils
      age
      bat
      tree
      btop-rocm
      fastfetch
      gemini-cli
      nftables
      wireguard-tools

      #nix
      nix-index
      nix-search-cli

      # net
      dig
      openssl
      traceroute
      inetutils
      wget

      # kuber
      kubernetes-helm
      kubectl
      k9s

      # archive
      zip
      unzip
    ];
  };
}
