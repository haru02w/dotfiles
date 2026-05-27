{
  den.aspects.virt-manager.nixos = {
    programs.virt-manager.enable = true;
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
