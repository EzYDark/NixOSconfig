{ pkgs, ... }: {
  imports = [ ./vscode.nix ];

  programs = { git.enable = true; };

  environment.systemPackages = [
    pkgs.nil
    pkgs.nixfmt

    # Rust
    pkgs.rustup
    pkgs.rust-analyzer
    pkgs.sccache
    pkgs.bacon
    # Commands to execute for Leptos setup:
    # (https://book.leptos.dev/getting_started/index.html#hello-world-getting-set-up-for-leptos-csr-development)
    #   rustup toolchain install nightly
    #   rustup default nightly
    #   rustup target add wasm32-unknown-unknown
    #   cargo install trunk
    #   cargo install leptosfmt
    #   cargo install cargo-leptos
    #   cargo install tauri-cli --version "^2.0.0-alpha"

    pkgs.figma-linux

    pkgs.go
    pkgs.gopls

    pkgs.tailwindcss
    pkgs.bun
    pkgs.nodejs_21
    pkgs.esbuild

    pkgs.just
  ];
}
