# enables `nix run .#vm`. it is very useful to have a VM
# you can edit your config and launch the VM to test stuff
# instead of having to reboot each time.
{
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.vm = pkgs.writeShellApplication {
        name = "vm";
        text =
          let
            host = inputs.self.nixosConfigurations.zephyrus.config;
          in
          ''
            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };
    };
}
