{ lib, linuxManualConfig, fetchFromGitHub, fetchzip, runCommand
, ... } @ args:

let
  patchRepo = fetchFromGitHub {
    owner = "t2linux";
    repo = "linux-t2-patches";
    rev = "b3628f2ab2d1c67c744d22c96758e75f6c191054";
    hash = "sha256-Cnqg2RS/ii19aw2vN86c7PjdnUYJCK88noxaFwH5WmQ=";
  };

  modDirVersion = "6.10.0";
  version = "6.10-upstream-config";
  pname = "t2-upstream-config-test";

  configPath = ./upstream_config;
in
linuxManualConfig {
  inherit modDirVersion version pname;
  # Snippet from nixpkgs
  allowImportFromDerivation = true;

  src = runCommand "patched-source" {} ''
    cp -r ${fetchzip {
      url = "mirror://kernel/linux/kernel/v6.x/linux-6.10.tar.xz";
      hash = "sha256-cWbH1/Ab3NqQJ1Gn/nX5koCcn1o1PexiMd5AXliNpDc=";
    }} $out
    chmod -R u+w $out
    cd $out
    while read -r patch; do
      echo "Applying patch $patch";
      patch -p1 < $patch;
    done < <(find ${patchRepo} -type f -name "*.patch" | sort)
  '';

  configfile = configPath;
}

