{
  description = "Advent of Code 2024";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells = {
        zig = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            zig
          ];

          shellHook = ''
            export SHELL="/run/current-system/sw/bin/zsh"
            exec $SHELL -c zellij
          '';
        };
        ocaml = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            dune_3
            ocamlPackages.ocaml
            ocamlPackages.ocaml-lsp
            ocamlPackages.ocamlformat
            ocamlPackages.core
            ocamlPackages.core_extended
            ocamlPackages.findlib
            ocamlPackages.utop
            ocamlPackages.ounit2
          ];

          shellHook = ''
            export SHELL="/run/current-system/sw/bin/zsh"
            exec zsh -c zellij
          '';
        };
        gleam = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            gleam
            erlang
            rebar3
          ];

          shellHook = ''
            export SHELL="/run/current-system/sw/bin/zsh"
            exec zsh -c zellij
          '';
        };
      };
    });
}
