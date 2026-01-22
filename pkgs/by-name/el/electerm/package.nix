# pkgs/by-name/ap/apifox/package.nix（完全对齐微信写法）
{ pkgs, lib, fetchurl, ... }:

let
  pname = "electerm";
  version = "2.3.198";

src = fetchurl {
  url = "https://gh-proxy.com/https://github.com/electerm/electerm/releases/download/v2.3.198/electerm-2.3.198-linux-x86_64.AppImage";
  # 替换为真实的sha256 hash（带sha256-前缀）
  hash = "sha256-0tHOtfv2LJmoDw6Ozw3gOtGD5uwy9ULIuaxOfqVyTSU=";
};

  appimageContents = pkgs.appimageTools.extract {
    inherit pname version src;
  };

in
# 4. 核心：使用wrapAppImage（和微信的wrapAppImage完全一致）
pkgs.appimageTools.wrapAppImage {
  inherit pname version;
  src = appimageContents; # 传入解压后的AppImage内容
  meta = with lib; {
    description = "ssh term";
    homepage = "https://github.com/electerm/electerm";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
  };

  # 5. 关键：和微信一样用extraInstallCommands（追加安装操作）
  extraInstallCommands = ''
    # 复制桌面文件（和微信的cp wechat.desktop逻辑一致）
    mkdir -p $out/share/applications
    cp ${appimageContents}/electerm.desktop $out/share/applications/

    # 复制图标（和微信的cp wechat.png逻辑一致，仅尺寸不同）
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${appimageContents}/electerm.png $out/share/icons/hicolor/256x256/apps/

    # 替换Exec字段（和微信的--replace-fail AppRun wechat逻辑一致）
    substituteInPlace $out/share/applications/electerm.desktop --replace-fail AppRun electerm
  '';

}
