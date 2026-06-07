{
  pkgs ? import <nixpkgs> { },
}:
let
  lbx-init = pkgs.pkgsStatic.callPackage ./nix/lbx-init.nix { };
in
pkgs.callPackage ./nix/litterbox.nix { inherit lbx-init; }
