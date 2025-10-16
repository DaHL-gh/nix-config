{
  config,
  lib,
  pkgs,
  ...
}:
let
  prompt = ''
    # ==============================
    # Color variables
    # ==============================
    set -g color_normal normal

    set -g color_retc_good green
    set -g color_retc_bad red
    set -g color_background_task white

    set -g color_user white
    set -g color_root red
    set -g color_at white
    set -g color_host white
    set -g color_host_ssh cyan
    set -g color_git white
    set -g color_venv magenta
    set -g color_cwd blue

    # ==============================
    # Main Prompt
    # ==============================
    function fish_prompt
        # ==============================
        # Retcode color
        # ==============================
        set -l retc $color_retc_bad
        test $status = 0; and set retc $color_retc_good

        # ==============================
        # Clear previous prompt line(s)
        # ==============================
        echo -ne "\033[2K"  # clear line
        echo -ne "\033[1A"  # move up 2 lines
        echo -ne "\033[2K"  # clear line

        # ==============================
        # Clear vi-mode prompt
        # ==============================
        function fish_mode_prompt; end

        # ==============================
        set_color $retc
        echo -n ' |'

        set_color $color_user
        if functions -q fish_is_root_user; and fish_is_root_user
            set_color $color_root
        end
        echo -n $USER

        set_color $color_at
        echo -n '@'

        if test -n "$SSH_CLIENT"
            set_color $color_host_ssh
        else
            set_color $color_host
        end
        set host (prompt_hostname)
        if set -q IN_NIX_SHELL
            set host "$host+nix"
        end
        echo -n $host
        set_color $retc
        echo -n '| '

        # Git
        type -q git
        and set -l g (fish_git_prompt '%b%a|●%u✚%m…%c')
        if test -n "$g"
            set_color $retc
            echo -n '- |'
            set_color $color_git
            echo -n $g
            set_color $retc
            echo -n '| '
        end

        # Virtualenv
        set -q VIRTUAL_ENV
        and begin
            set_color $color_venv
            echo -n '<'
            echo -n (basename "$VIRTUAL_ENV")
            echo -n '> '
        end

        # Current directory
        set_color $retc
        echo -n '- '
        set_color $color_cwd
        echo -n (prompt_pwd)

        echo  # newline for jobs

        # ==============================
        # Background jobs
        # ==============================
        for job in (jobs)
            set_color $retc
            echo -n ' | '
            set_color $color_background_task
            echo $job
        end

        # ==============================
        # Prompt symbol
        # ==============================
        set_color $retc
        echo -n ' > '
        set_color $color_normal
    end
  '';
in
{
  options.localModules.fish.enable = lib.mkEnableOption "Just fish";

  config = lib.mkIf config.localModules.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = prompt;
      shellInit = "direnv hook fish | source\n";
    };

    home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

    home.packages = with pkgs; [ direnv ];
  };
}
