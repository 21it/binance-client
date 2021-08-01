let nixpkgs = import ./nixpkgs.nix;
in
{
  pkgs ? import nixpkgs {
    overlays = import ./overlay.nix {
      inherit vimBackground vimColorScheme;
    };
  },
  vimBackground ? "light",
  vimColorScheme ? "PaperColor",
  gitAuthorName,
  gitAuthorEmail
}:
with pkgs;

stdenv.mkDerivation {
  name = "binance-client-shell";
  buildInputs = [
    /* IDE */
    haskell-ide
    /* Utils */
    git
    nix-prefetch-scripts
    openssh
    cabal2nix
    cacert
    xxd
  ];

  TERM="xterm-256color";
  LC_ALL="C.UTF-8";
  GIT_SSL_CAINFO="${cacert}/etc/ssl/certs/ca-bundle.crt";
  NIX_SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  NIX_PATH="/nix/var/nix/profiles/per-user/root/channels";
  GIT_AUTHOR_NAME=gitAuthorName;
  GIT_AUTHOR_EMAIL=gitAuthorEmail;
  EMAIL = gitAuthorEmail;
  shellHook = ''
    source ./nix/export-test-envs.sh

    export HOOGLEDB=/root/.hoogle
    if [ "$(ls -A $HOOGLEDB)" ]; then
      echo "hoogle database already exists..."
    else
      echo "building hoogle database..."
      stack --stack-yaml=/app/stack.yaml exec hoogle generate
    fi

    if [ "$(ls -A ~/.cabal)" ]; then
      echo "cabal database already exists..."
    else
      echo "building cabal database..."
      cabal v2-update
    fi
  '';
}
