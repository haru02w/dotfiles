{ den, ... }:
{
  den.aspects.system-packages.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
        wget
        sshfs
        networkmanagerapplet
      ];
    };
}
