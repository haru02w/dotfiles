{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs.nixos-hardware = {
    url = "github:NixOS/nixos-hardware";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.zephyrus.includes = [
    den.aspects.nvidia
    den.aspects.firmware
    den.aspects.grub
  ];
  den.aspects.zephyrus.nixos = {
    imports = [
      inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ];
    services.asusd.enable = true;
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
