{inputs, ...}:
with inputs; [
  nix-alien.overlays.default
  nur.overlay
]
