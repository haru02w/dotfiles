{inputs, ...}:
{
  nixnvc = inputs.nixnvc.overlays.default;
  nur = inputs.nur.overlay;
}
