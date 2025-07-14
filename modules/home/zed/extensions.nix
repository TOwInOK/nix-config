{pkgs, ...}: {
  programs.zed-editor.extensions = [
    "HTML"
    "Catppucin"
    "TOML"
    "Dockerfile"
    "Git-Firefly"
    "Discord-Presence"
    "RON"
  ];
  programs.zed-editor.extraPackages = with pkgs; [
    nixd
    ruff
  ];
}
