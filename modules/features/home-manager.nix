{
  den.aspects.home-manager-self.homeManager = {
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
