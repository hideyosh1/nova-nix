{
  lib,
  autoPatchelfHook,
  stdenv,
  dpkg,
  fetchurl,
  cups,
  dbus,
  egl-gbm,
  egl-x11,
  egl-wayland,
  eglexternalplatform,
  fontconfig,
  freetype,
  libgcc,
  libGL,
  glib,
  libGLU,
  libGLX,
  gcc,
  krb5,
  libkrb5,
  xz,
  ncurses,
  gfortran,
  qt6,
  gtk3,
  gdk-pixbuf,
  pango,
  cairo,
  sqlite,
  openssl_3_5,
  python311,
  libtinfo,
  libuuid,
  libx11,
  libxcb,
  libxcb-cursor,
  libxcb-image,
  libxcb-keysyms,
  libxcb-render-util,
  libxcb-util,
  libxcb-wm,
  libxkbcommon,
  libz,
}:
stdenv.mkDerivation rec {
  pname = "mnova";

  version = "17.0.0-41178";

  src = fetchurl {
    url = "https://mestrelab.com/downloads/mnova/linux/Debian/13/mestrenova_${version}_amd64.deb";
    hash = "sha256-d8UQjiaxbtYNrwYPTF97gOV2MaRvt9B9Q4AI5oDlz/E=";
  };

  buildInputs = [
    qt6.qtbase
    qt6.qtwayland

    python311
    cups
    dbus
    egl-gbm
    egl-x11
    egl-wayland
    eglexternalplatform
    fontconfig
    freetype
    libgcc
    libGL
    glib
    libGLU
    libGLX
    gcc
    krb5.lib
    libkrb5
    xz
    ncurses
    gfortran.cc
    sqlite
    openssl_3_5
    python311
    libtinfo
    libuuid
    libx11
    libxcb
    libxcb-cursor
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-util
    libxcb-wm
    libxkbcommon
    libz

    gtk3
    gdk-pixbuf
    pango
    cairo
  ];

  nativeBuildInputs = [
    dpkg
    qt6.wrapQtAppsHook
    autoPatchelfHook
  ];

  installPhase = ''
    runHook preInstall

    dpkg -x $src $out
    mv $out/opt/MestReNova/* $out

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    substituteInPlace $out/bin/MestReNova \
      --replace-fail '/bin/bash' "/usr/bin/env sh"

    runHook postFixup
  '';

  meta = {
    description = "MestReNova is a multivendor software suite designed for combined NMR, LC/GC/MS and Electronic & Vibrational Spectroscopic techniques.";
    homepage = "https://mestrelab.com/main-product/mnova";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [
      hideyosh1
    ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "MestReNova";
  };
}
