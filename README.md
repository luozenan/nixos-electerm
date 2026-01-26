官方网站：https://github.com/electerm/electerm

electerm for nixos

install:
flake inputs:

###
 electerm-github = {
 
    url = "github:luozenan/nixos-electerm";
    
    inputs.nixpkgs.follows = "nixpkgs";
  }; 
###

###
environment.systemPackages = [

     inputs.electerm-github.packages.${pkgs.stdenv.hostPlatform.system}.electerm
     
 ]
###
 
