{
  lib,
  rustPlatform,
  makeWrapper,
  podman,
  coreutils,
  lbx-init,
}:
let
  cargoToml = builtins.fromTOML (builtins.readFile ../litterbox/Cargo.toml);
in
rustPlatform.buildRustPackage {
  pname = "litterbox";
  version = cargoToml.package.version;

  src = ../.;

  buildAndTestSubdir = "litterbox";
  cargoRoot = "litterbox";
  cargoLock.lockFile = ../litterbox/Cargo.lock;

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    install -Dm755 ${lbx-init}/bin/lbx-init $out/bin/lbx-init
    wrapProgram $out/bin/litterbox \
      --prefix PATH : ${
        lib.makeBinPath [
          podman
          coreutils
        ]
      }
  '';

  meta = {
    description = "Somewhat Isolated Development Environments";
    homepage = "https://github.com/Gerharddc/Litterbox";
    license = lib.licenses.asl20;
    mainProgram = "litterbox";
  };
}
