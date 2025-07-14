{
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  powerManagement.cpuFreqGovernor = "performance";

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  swapDevices = lib.mkForce [];

  services.xserver.videoDrivers = ["nvidia"];

  # Enable nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaSettings = true;
    open = true;
  };
}
