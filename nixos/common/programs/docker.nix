{ pkgs, ... }: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerSocket.enable = true;
      extraPackages = [ pkgs.podman-compose ];
    };
  };
}
