let 
  pkgs = import <nixpkgs> {};
in
{
  upstream-config = pkgs.callPackage ./upstream-config.nix { };
  noa-config = pkgs.callPackage ./noa-config { };
}
