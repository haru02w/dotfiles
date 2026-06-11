{
  den.aspects.virt-manager.nixos =
    { pkgs, ... }:
    {
      programs.virt-manager.enable = true;
      # virt-manager stores its settings in dconf
      programs.dconf.enable = true;

      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            # OVMF UEFI firmware ships by default now.
            # TPM 2.0 emulation (Windows 11 etc.)
            swtpm.enable = true;
            runAsRoot = false;
          };
        };
        spiceUSBRedirection.enable = true;
      };

      environment.systemPackages = with pkgs; [
        virtiofsd # virtiofs shared-folder support
        spice-gtk # SPICE client / USB redirect helpers
        swtpm
      ];
    };
}
