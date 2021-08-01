{
  vimBackground ? "light",
  vimColorScheme ? "PaperColor"
}:
[
  (self: super:
    let
      callPackage = self.lib.callPackageWith self.haskellPackages;
      dontCheck = self.haskell.lib.dontCheck;
      doJailbreak = self.haskell.lib.doJailbreak;
    in
      {
        haskell-ide = import (
          fetchTarball "https://github.com/tkachuk-labs/ultimate-haskell-ide/tarball/f27011bcacd287862089bd723a23e6539f9d5270"
        ) {inherit vimBackground vimColorScheme;};
        haskellPackages = super.haskell.packages.ghc865.extend(
          self': super': {
            universum = dontCheck super'.universum;
          }
        );
      })
]
