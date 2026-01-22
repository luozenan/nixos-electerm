electerm for nixos

install:

environment.systemPackages = [
     inputs.electerm-github.packages.${pkgs.stdenv.hostPlatform.system}.electerm
 ]
