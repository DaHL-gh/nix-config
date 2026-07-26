{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    mkIf
    ;

  cfg = config.mutableNix;
  isHM = true;
in
{
  options.mutableNix = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    roots = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            source = mkOption { type = types.path; };
            target = mkOption { type = types.str; };

            user = mkOption {
              type = types.nullOr types.str;
              default = if isHM then config.home.username else null;
              description = "Владелец директории.";
            };

            group = mkOption {
              type = types.nullOr types.str;
              default = if isHM then null else "users";
              description = "Группа директории.";
            };
          };
        }
      );
    };

    links = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            root = mkOption { type = types.str; };
            from = mkOption { type = types.str; };
            to = mkOption { type = types.str; };
          };
        }
      );
    };
  };

  config = mkIf (cfg.enable && isHM) {
    # Выводим предупреждения во время эвалуации, если user/group переопределены в HM
    home.activation.mutableNixCheck = lib.hm.dag.entryBefore [ "checkLinkTargets" ] (
      lib.concatMapStringsSep "\n" (
        name:
        let
          root = cfg.roots.${name};
        in
        if root.user != config.home.username || root.group != null then
          builtins.trace "Warning [mutableNix]: user/group for root '${name}' are ignored in Home Manager" ""
        else
          ""
      ) (builtins.attrNames cfg.roots)
    );

    home.activation.mutableNixRoots = lib.hm.dag.entryAfter [ "writeBoundary" ] (
      lib.concatMapStringsSep "\n"
        (item: ''
          if [ ! -e "${item.root.target}" ]; then
            echo "mutableNix: initializing root '${item.name}'"
            mkdir -p "$(dirname "${item.root.target}")"
            cp -r "${item.root.source}/." "${item.root.target}"
          fi
        '')
        (
          lib.mapAttrsToList (name: root: {
            inherit name root;
          }) cfg.roots
        )
    );

    home.activation.mutableNix = lib.hm.dag.entryAfter [ "mutableNixRoots" ] (
      lib.concatMapStringsSep "\n" (link: ''
        mkdir -p "$(dirname "${link.to}")"
        if [ -e "${link.to}" ] && [ ! -L "${link.to}" ]; then
          echo "Error: mutableNix target '${link.to}' already exists and is a real file! Aborting."
          exit 1
        fi
        ln -sfn "${cfg.roots.${link.root}.target}/${link.from}" "${link.to}"
      '') cfg.links
    );
  };
}
