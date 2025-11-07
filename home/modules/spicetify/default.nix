{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  options.localModules.spicetify.enable = lib.mkEnableOption "SPICEtify";

  config = lib.mkIf config.localModules.spicetify.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        playNext
        playingSource
        beautifulLyrics
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        marketplace
      ];
      enabledSnippets = with spicePkgs.snippets; [
        pointer
        # dynamicSearchBar
        thinLibrarySidebarRows
        hideLyricsButton
      ];

      # theme = spicePkgs.themes.catppuccin;
      # colorScheme = "mocha";
    };
  };
}
