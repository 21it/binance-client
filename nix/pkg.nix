{ mkDerivation, aeson, async, base, bytestring, chronos, containers
, cryptonite, envparse, esqueleto, extra, hpack, hspec, http-client
, http-client-tls, http-types, katip, persistent
, persistent-postgresql, persistent-template, retry, safe-money
, stdenv, stm, template-haskell, text, time, transformers
, unbounded-delays, universum, unliftio
}:
mkDerivation {
  pname = "binance-client";
  version = "0.1.0.0";
  src = ./..;
  libraryHaskellDepends = [
    aeson async base bytestring chronos containers cryptonite envparse
    esqueleto extra hspec http-client http-client-tls http-types katip
    persistent persistent-postgresql persistent-template retry
    safe-money stm template-haskell text time transformers
    unbounded-delays universum unliftio
  ];
  libraryToolDepends = [ hpack ];
  testHaskellDepends = [
    aeson async base bytestring chronos containers cryptonite envparse
    esqueleto extra hspec http-client http-client-tls http-types katip
    persistent persistent-postgresql persistent-template retry
    safe-money stm template-haskell text time transformers
    unbounded-delays universum unliftio
  ];
  prePatch = "hpack";
  homepage = "https://github.com/tkachuk-labs/binance-client#readme";
  license = stdenv.lib.licenses.bsd3;
}
