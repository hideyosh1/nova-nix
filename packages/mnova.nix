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
  python314,
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

  version = "14.3.3-33362";

  src = fetchurl {
    url = "https://mestrelab.com/downloads/mnova/linux/Debian/11/mestrenova_${version}_amd64.deb";
    hash = "sha256-aaa0VW06uO7VtT5QWdAn6RenPIxGi9i64glT0STVSo4=";
  };

  buildInputs = [
    qt6.qtbase
    qt6.qtwayland

    cups
    dbus
    eglexternalplatform
    egl-gbm
    egl-wayland
    egl-x11
    fontconfig
    freetype
    gcc
    gfortran.cc
    glib
    krb5.lib
    libgcc
    libGL
    libGLU
    libGLX
    libkrb5
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
    ncurses
    openssl_3_5
    python314
    sqlite
    xz
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

    substituteInPlace $out/share/applications/MestReNova.desktop \
      --replace-fail 'Exec=' "Exec=env "

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
