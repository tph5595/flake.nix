{pkgs }:

pkgs.writeShellScriptBin "dvt" ''
    if [[ $# -eq 0 ]]; then c=default; else c=$1; fi; nix flake init --template "github:tph5595/flake.nix#$c" && direnv allow
''
