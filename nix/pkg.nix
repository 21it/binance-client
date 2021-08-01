{ mkDerivation, async, base, bytestring, chronos, containers
, envparse, esqueleto, extra, hpack, hspec, katip, persistent
, persistent-postgresql, persistent-template, retry, stdenv, stm
, template-haskell, text, time, unbounded-delays, universum
, unliftio
}:
mkDerivation {
  pname = "binance-client";
  version = "0.1.0.0";
  src = ./..;
  libraryHaskellDepends = [
    async base bytestring chronos containers envparse esqueleto extra
    hspec katip persistent persistent-postgresql persistent-template
    retry stm template-haskell text time unbounded-delays universum
    unliftio
  ];
  libraryToolDepends = [ hpack ];
  testHaskellDepends = [
    async base bytestring chronos containers envparse esqueleto extra
    hspec katip persistent persistent-postgresql persistent-template
    retry stm template-haskell text time unbounded-delays universum
    unliftio
  ];
  prePatch = "hpack";
  homepage = "https://github.com/tkachuk-labs/binance-client#readme";
  license = stdenv.lib.licenses.bsd3;
}
