{
  fileSystems."/mnt/bkpsys" = {
    device = "bkpsys.acmesecurity.org:/";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
}
