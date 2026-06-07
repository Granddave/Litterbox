{
  rustPlatform,
  lib,
}:
let
  cargoToml = builtins.fromTOML (builtins.readFile ../lbx-init/Cargo.toml);
in
rustPlatform.buildRustPackage {
  pname = "lbx-init";
  version = cargoToml.package.version;
  src = ./..;

  buildAndTestSubdir = "lbx-init";
  cargoRoot = "lbx-init";
  cargoLock.lockFile = ../lbx-init/Cargo.lock;

  meta = {
    description = "Litterbox container entrypoint";
    homepage = "https://github.com/Gerharddc/Litterbox";
    license = lib.licenses.asl20;
    mainProgram = "lbx-init";
  };
}
