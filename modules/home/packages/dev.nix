{pkgs, ...}: {
  home.packages = with pkgs; [
    ## Lsp
    nixd # nix

    ## formating
    shfmt
    treefmt
    nixfmt-rfc-style

    # rust
    cargo
    rustc

    ## C
    gcc

    # JS/TS
    deno
    nodejs

    ## Python
    python3
    ruff
  ];
}
