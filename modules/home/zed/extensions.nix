{ pkgs, ... }:
{
  programs.zed.extensions = ["HTML" "Catppucin" "TOML" "Dockerfile" "Git-Firefly" "Discord-Presence" "RON"];
  programs.zed.extraPackages =  with pkgs; [ nixd ruff ]
}