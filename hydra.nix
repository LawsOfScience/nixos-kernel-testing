{
  build = {system ? builtins.currentSystem}: let
    pkgs = import <nixpkgs> {inherit system;};
  in {
    t2-upstream-config = pkgs.lib.hydraJob (pkgs.callPackage ./upstream-config.nix {});
    t2-noa-config = pkgs.lib.hydraJob (pkgs.callPackage ./noa-config.nix {});
  };
}
