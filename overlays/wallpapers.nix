final: prev: {
  foe-wallpapers = prev.stdenv.mkDerivation {
    name = "foehammer-wallpapers";

    src = ../wallpapers;

    installPhase = ''
      mkdir $out

      cp -r $src/* $out
    '';
  };
}
