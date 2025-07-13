{ pkgs, ... }:
{
  boot.loader.limine;
  boot.loader.limine.maxGenerations = 10;
  boot.kernelPackages = pkgs.linuxPackages_zen;
}