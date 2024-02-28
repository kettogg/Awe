{ fetchFromGitHub, fetchurl, stdenv }:

let
  imgLink = "https://github.com/re1san/Awe/blob/walls/Tokyo.png?raw=true";

  image = fetchurl {
    url = imgLink;
    sha256 = "sha256-cyLKUkF5MK7NS6qm/FfmfNLxTnSfcyR/dCtO8GJxg/Y=";
  };
in
stdenv.mkDerivation rec {
  pname = "sddm-sugar-candy";
  version = "1.6";
  src = fetchFromGitHub {
    owner = "Kangie";
    repo = pname;
    rev = "v1.6";
    sha256 = "18wsl2p9zdq2jdmvxl4r56lir530n73z9skgd7dssgq18lipnrx7";
  };

  patches = [
    ../../patches/sddm.diff 
  ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes/Sugar-Candy
    cp -R ./* $out/share/sddm/themes/Sugar-Candy 
    cp -r ${image} $out/share/sddm/themes/Sugar-Candy/Backgrounds/Default.png
   '';
}
