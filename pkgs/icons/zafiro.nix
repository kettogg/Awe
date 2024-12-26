{ fetchurl, stdenv }:

stdenv.mkDerivation {
  name = "zafiro-icons-dark-blue";

  src = fetchurl {
    url = "https://github.com/ketto/Awe/files/14420794/Zafiro-Icons-Dark-Blue.tar.gz";
    hash = "sha256-35TDWdJKEgJKjqjQqW2Bc6wQBNCZIqiGYiFtYxdynGw=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/icons
    tar -xzf $src -C $out/share/icons 
  '';
}
