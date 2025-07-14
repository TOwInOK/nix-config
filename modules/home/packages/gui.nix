{pkgs, ...}: {
  home.packages = with pkgs; [
    ## Multimedia
    audacity
    gimp
    obs-studio
    pavucontrol
    soundwireserver
    video-trimmer
    vlc

    ## Office
    libreoffice
    kdePackages.kcalc
    kdePackages.kleopatra

    ## Utility
    dconf-editor
    gnome-disk-utility
    mission-center # GUI resources monitor
    zenity
  ];
}
