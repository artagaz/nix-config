{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "assistant";
  version = "1.0";

  src = ./assistant.deb;

  nativeBuildInputs = [
    pkgs.dpkg
    pkgs.autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    glibc
    gcc.cc.lib
    libz
    libx11
    libXext
    libXrender
    libXtst
    libXi
    libXfixes
    libXft
    glib
    pango
    cairo
    atk
    gdk-pixbuf
    gtk2
    dbus
    fontconfig
    freetype
    nss
    nspr
    alsa-lib
    # НОВЫЕ ЗАВИСИМОСТИ ИЗ ЛОГА:
    pipewire # для libpipewire-0.3.so.0
    libpulseaudio # для libpulse.so.0 и libpulse-simple.so.0
    sqlite # на всякий случай, был в логах
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out
    if [ -d "usr" ]; then
      cp -r usr/* $out/
    else
      cp -r * $out/
    fi

    # Создаем бинарник в системном пути
    mkdir -p $out/bin
    if [ -f "$out/opt/assistant/bin/assistant" ]; then
      ln -s $out/opt/assistant/bin/assistant $out/bin/assistant
    fi
  '';
}
