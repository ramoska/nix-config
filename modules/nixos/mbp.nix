{ pkgs, lib, ... }: 

{
  boot.kernelModules = [ "kvm-intel" "brcmfmac" "hci_uart" "btbcm" ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  
  services.udev.extraRules = "SUBSYSTEM==\"drm\", DRIVERS==\"amdgpu\", ATTR{device/power_dpm_force_performance_level}=\"low\"";
}

