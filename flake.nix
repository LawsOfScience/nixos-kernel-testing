{
  description = "The Linux kernel, but built how the T2 Arch kernel is";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      packages.x86_64-linux = {
        upstream-config = pkgs.callPackage ./upstream-config.nix { };
        noa-config = pkgs.callPackage ./noa-config.nix { };
      };
    };
}
