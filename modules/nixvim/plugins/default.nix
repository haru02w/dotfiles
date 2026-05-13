{lib, ...}: {
  imports = let
    # Add paths here to skip auto-import (e.g. ./extra/foo.nix)
    excluded = [];
    isNixFile = path: lib.hasSuffix ".nix" (toString path);
    isNotSelf = path: (toString path) != (toString ./default.nix);
    isNotExcluded = path: !(builtins.elem path excluded);
  in
    builtins.filter
    (path: isNixFile path && isNotSelf path && isNotExcluded path)
    (lib.filesystem.listFilesRecursive ./.);
}
