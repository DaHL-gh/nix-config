{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.localModules.git.enable = lib.mkEnableOption "Just git n else";

  config = lib.mkIf config.localModules.git.enable {
    programs.git = {
      enable = true;
      userName = "DaHL";
      userEmail = "8tima18@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";

        merge = {
          tool = "diffview";
        };

        mergetool = {
          prompt = false;
          keepBackup = false;
          diffview.cmd = "nvim -n -c \"DiffviewOpen\" \"$MERGE\"";
          nvimdiff.layout = "LOCAL,BASE,REMOTE / MERGED";
        };

        diff = {
          tool = "nvimdiff";
        };

        difftool = {
          prompt = false;
          nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };

        alias = {
          dt = "! args=$@; shift $#; nvim -c \"DiffviewOpen $args\"";
        };
      };

      delta.enable = true;
      delta.options = {
        side-by-side = true;
        line-numbers = true;
      };

    };

    # programs.delta ={
    #   enable = true;
    #   options = {
    #     side-by-side = true;
    #     line-numbers = true;
    #     syntax-theme = "Dracula";
    #   };
    # };

    home.packages = with pkgs; [
      gh
      lazygit
    ];
  };
}
