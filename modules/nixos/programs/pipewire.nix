{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nix;
in {
  options.modules.programs.pipewire.enable = mkEnableOption "Pipewire sound system";
  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = mkForce false;
    security.rtkit.enable = mkForce true;
    services.pipewire = {
      enable = mkDefault true;
      alsa.enable = mkDefault true;
      alsa.support32Bit = mkDefault true;
      pulse.enable = mkDefault true;
      jack.enable = mkDefault true;
    };
  };
}
