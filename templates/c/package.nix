{ lib
, stdenv
, pkgs
, enableTests ? true
, ...
}:
stdenv.mkDerivation {
  name = "main";

  # important for caching
  src = ./.;

  # packages at compilationtime
  nativeBuildInputs = with pkgs;[ cmake ];
  # packages at testing
  checkInputs = [];
  # packages at run time
  BuildInputs = [];
  doCheck = enableTests;
  cmakeFlags = lib.optional (!enableTests) "-DTESTING=off";
}
