{
  description = "Linux sandbox environment for developers";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lbx-init = pkgs.pkgsStatic.callPackage ./nix/lbx-init.nix { };
        litterbox = pkgs.callPackage ./nix/litterbox.nix { inherit lbx-init; };
      in
      {
        packages.lbx-init = lbx-init;
        packages.litterbox = litterbox;
        packages.default = litterbox;
      }
    );
}
