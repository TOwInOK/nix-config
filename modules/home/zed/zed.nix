{ pkgs, ... }:
{
  programs.zed = {
    enable = true;
    package = pkgs.zed-editor;
  };
}
