# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../shared
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "zephyrus";
  
  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # asus-linux
  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;

    /* asusdConfig = ''
(
    charge_control_end_threshold: 81,
    panel_od: false,
    mini_led_mode: false,
    disable_nvidia_powerd_on_battery: true,
    ac_command: "",
    bat_command: "",
    platform_policy_on_battery: Quiet,
    platform_policy_on_ac: Performance,
    ppt_pl1_spl: None,
    ppt_pl2_sppt: None,
    ppt_fppt: None,
    ppt_apu_sppt: None,
    ppt_platform_sppt: None,
    nv_dynamic_boost: None,
    nv_temp_target: None,
)
    ''; */
  };

  # Battery improvements
  powerManagement.enable = true;
  services.tlp = {
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 25;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 75; # 75 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # Nvidia driver
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true; # WARN: can cause problems
    powerManagement.finegrained = true;
    open = false;# Not opensourced driver
    nvidiaSettings = true;
    prime = {
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
      offload = {
			  enable = true;
			  enableOffloadCmd = true;
		  };
    };
  };

  # Enable opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "24.05";
}

