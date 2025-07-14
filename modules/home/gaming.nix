{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ## Utils
    gamemode
    gamescope
    winetricks
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    ## Minecraft
    prismlauncher
  ];
}
