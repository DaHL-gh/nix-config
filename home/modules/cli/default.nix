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
      bat
      tree
      btop-rocm
      fastfetch
      gemini-cli
      nftables

      #nix
      nix-index
      nix-search-cli

      # net
      openssl
      dig
      traceroute

      # kuber
      kubernetes-helm
      kubectl
      k9s

      wireguard-tools

      # archive
      zip
      unzip
    ];
  };
}
