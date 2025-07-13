{ ... }:
{
  imports = [
    ./aseprite/aseprite.nix           # pixel art editor
    ./audacious.nix                   # music player
    ./bat.nix                         # better cat command
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./cava.nix                        # audio visualizer
    ./discord.nix                     # discord
    ./fastfetch.nix                   # fetch tool
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./ghostty.nix                     # terminal
    ./git.nix                         # version control
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    # ./hyprland                        # window manager
    ./lazygit.nix
    ./micro.nix                       # nano replacement
    ./nix-search/nix-search.nix       # TUI to search nixpkgs
    ./nvim.nix                        # neovim editor
    ./p10k/p10k.nix
    ./nemo.nix                        # File browser for Cinnamon
    ./packages                        # other packages
    # ./rofi.nix                        # launcher
    ./scripts/scripts.nix             # personal scripts
    ./ssh.nix                         # ssh config
    ./superfile/superfile.nix         # terminal file manager
    # ./swaylock.nix                    # lock screen
    # ./swayosd.nix                     # brightness / volume wiget
    # ./swaync/swaync.nix               # notification deamon
    # ./viewnior.nix                    # image viewer
    # ./vscodium                        # vscode fork
    ./zed                               # zed editor
    # ./waybar                          # status bar
    # ./waypaper.nix                    # GUI wallpaper picker
    ./xdg-mimes.nix                   # xdg config
    ./zsh                             # shell
  ];
}
