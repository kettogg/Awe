{ fetchurl, stdenv }:

stdenv.mkDerivation rec {
  pname = "fuyu";
  version = "1.0"; # Dummy version for pname
  src = fetchurl {
    url = "https://github.com/ketto/Awe/files/14424629/Fuyu.tar.gz";
    hash = "sha256-W1QGYdWfT4R2bN15D4oHsnQvLhKQEteuP9LeefG05Xw=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/icons
    tar -xzf $src -C $out/share/icons 
  '';
}
