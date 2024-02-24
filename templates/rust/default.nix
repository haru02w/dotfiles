{ rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "rust_template";
  version = "0.1.0";

  src = ./.;
  cargoLock.lockFile = ./Cargo.lock;
}
