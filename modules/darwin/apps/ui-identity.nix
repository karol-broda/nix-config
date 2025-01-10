{
  config,
  pkgs,
  lib,
  ...
}: {
  options.ubntIdentityEnterprise = lib.mkOption {
    type = lib.types.package;
    description = "ui identity enterprise app package derivation.";
  };

  config.ubntIdentityEnterprise = let
    version = "0.83.1";
  in
    pkgs.stdenv.mkDerivation {
      name = "ubnt-identity-enterprise-${version}";
      src = pkgs.fetchurl {
        url = "https://fw-download.ubnt.com/data/uid-ui-desktop-app/1e8e-macOS-0.83.1-247e0da2-e897-406e-ab55-fab75720bc60.pkg";
        sha256 = "1cn00cnav6hwifdnvdvxm062wb6d1nmr6x5xdsy616ja3ks5xlh0";
      };
      phases = ["installPhase"];
      nativeBuildInputs = [pkgs.xar pkgs.cpio];

      installPhase = ''
        set -x
        mkdir -p $out
        mkdir -p ./pkg-extracted ./payload-unpacked

        xar -xf "$src" -C ./pkg-extracted

        for payload in ./pkg-extracted/*.pkg/Payload; do
          if [ -f "$payload" ]; then
            cat "$payload" | gunzip -c | cpio -i -D ./payload-unpacked
          else
            echo "no payload found in $payload"
          fi
        done

        if [ "$(ls -A ./payload-unpacked)" ]; then
          cp -r ./payload-unpacked/* $out/
        else
          echo "No files were extracted from the payload."
          exit 1
        fi
      '';

      meta = {
        description = "UI Identity Enterprise app package derivation.";
        version = version;
        homepage = "https://www.ui.com";
      };
    };
}
