{ pkgs, ... }:
{
  boot.loader.limine.enable = true;
  boot.loader.limine.maxGenerations = 10;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.limine.extraEntries = [
    {
      name = "Windows";
      efi = "/EFI/Microsoft/Boot/bootmgfw.efi";
    }
  ];
}
