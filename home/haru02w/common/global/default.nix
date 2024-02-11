{outputs, ...}:
{
  imports = builtins.attrValues outputs.homeManagerModules;

  home.stateVersion = "23.11";

  # reload services when update home-manager
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "haru02w";
  home.homeDirectory = "/home/haru02w";
}
