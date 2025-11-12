{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "gamma-launcher";
  src = pkgs.fetchurl {
    url = "https://github.com/Mord3rca/gamma-launcher/releases/download/v2.5/gamma-launcher";
    sha256 = "sha256-aaI7vGjyK5GHRPuiYv4uGF7vQDnbmwyCJUqIatiNlR4=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];
  buildInputs = [
    pkgs.unrar
    pkgs.p7zip
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/gamma-launcher
    chmod +x $out/bin/gamma-launcher

    wrapProgram $out/bin/gamma-launcher \
      --prefix LD_LIBRARY_PATH : "${pkgs.unrar}/lib" \
      --set UNRAR_LIB_PATH "${pkgs.unrar}/lib/libunrar.so" \
      --prefix PATH : "${pkgs.p7zip}/bin"
  '';
}
