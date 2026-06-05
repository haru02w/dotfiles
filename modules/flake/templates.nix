{ lib, ... }:
let
  templatesDir = ../../templates;

  descriptions = {
    c = "C project: CMake + clang-format + direnv flake devshell";
    cpp = "C++ project: CMake + clang-format + direnv flake devshell";
    cpp-xmake = "C++ project using xmake + clang-format + direnv flake devshell";
    devshell = "Bare flake devshell + direnv";
    go = "Go project flake devshell + direnv";
    python = "Python project: uv/pyproject + package.nix + flake devshell";
    rust = "Rust project: cargo + flake devshell + direnv";
  };

  # Auto-discover every directory under ./templates as a template.
  names = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir templatesDir));
in
{
  flake.templates = lib.genAttrs names (name: {
    path = templatesDir + "/${name}";
    description = descriptions.${name} or name;
  });
}
