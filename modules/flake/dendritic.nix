{inputs, ...}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.flake-file.flakeModules.nix-auto-follow or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";
    home-manager.url = "github:nix-community/home-manager";
  };
}
