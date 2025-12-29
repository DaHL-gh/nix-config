{ lib }:
{
  allSubdirs =
    rootPath:
    let
      # { "fileordirname" = "regular|directory" ... }
      dirset = lib.filterAttrs (_: type: type == "directory") (builtins.readDir rootPath);
      dirs = map (lib.path.append rootPath) (builtins.attrNames dirset);
    in
    dirs;
}
