# /home/l/nix/flake.nix（最终版，跨版本兼容）
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    # 核心：直接用相对路径callPackage（Flake会自动解析根目录）
    packages.${system} = {
      # 相对路径：从Flake根目录（/home/l/nix）指向package.nix
      electerm = pkgs.callPackage ./pkgs/by-name/el/electerm/package.nix { };
      default = self.packages.${system}.electerm; # 设为默认包
    };
  };
}
