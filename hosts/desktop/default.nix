{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaSettings = true;
    open = false;
  };
}
